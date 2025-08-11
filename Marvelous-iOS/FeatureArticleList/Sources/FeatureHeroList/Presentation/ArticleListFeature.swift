import ComposableArchitecture
import CoreModels

public struct ArticleListFeature: Reducer {
    public struct State: Equatable, Sendable {
        public var items: [Article] = []
        public var isLoading = false
        public var errorMessage: String?
        public var searchQuery: String = "apple" // NewsAPI requires q; give it a default
        public var page = 1
        public var pageSize = 21    // 3 columns x 7 rows per “page”
        public var total = 0
        public init() {}
        public var canLoadMore: Bool { items.count < total }
    }
    public enum Action: Sendable {
        case onAppear
        case loadMore
        case searchQueryChanged(String)
        case articlesResponse(Result<([Article], total: Int), Error>)
    }

    public var fetch: @Sendable (String, Int, Int) async throws -> ([Article], Int)

    public init(fetch: @escaping @Sendable (String, Int, Int) async throws -> ([Article], Int)) {
        self.fetch = fetch
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.items.isEmpty else { return .none }
                state.isLoading = true
                let query = state.searchQuery
                let page = state.page, size = state.pageSize
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, page, size) }))
                }

            case .loadMore:
                guard !state.isLoading, state.canLoadMore else { return .none }
                state.isLoading = true
                state.page += 1
                let query = state.searchQuery
                let page = state.page, size = state.pageSize
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, page, size) }))
                }

            case let .searchQueryChanged(query):
                state.searchQuery = query
                state.page = 1
                state.items = []
                state.total = 0
                state.isLoading = true
                let size = state.pageSize
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, 1, size) }))
                }

            case let .articlesResponse(.success((newItems, total))):
                state.isLoading = false
                state.total = total
                state.items.append(contentsOf: newItems)
                return .none

            case let .articlesResponse(.failure(err)):
                state.isLoading = false
                state.errorMessage = err.localizedDescription
                return .none
            }
        }
    }
}
