import ComposableArchitecture
import CoreModels

public struct ArticleListFeature: Reducer {
    public struct State: Equatable, Sendable {
        public var items: [Article] = []
        public var isLoading = false
        public var errorMessage: String?
        public var searchQuery: String = ""
        public var page = 1
        public var total = 0
        public init() {}
    /// Only allow loading more if we have less than both the API total and 100 articles
    public var canLoadMore: Bool { items.count < min(total, 100) }
    }
    public enum Action: Sendable {
        case onAppear
        case loadMore
        case searchQueryChanged(String)
        case articlesResponse(Result<([Article], total: Int), Error>)
    }

    public var fetch: @Sendable (String, Int) async throws -> ([Article], Int)

    public init(fetch: @escaping @Sendable (String, Int) async throws -> ([Article], Int)) {
        self.fetch = fetch
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.items.isEmpty else { return .none }
                state.isLoading = true
                let query = state.searchQuery
                let page = state.page
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, page) }))
                }

            case .loadMore:
                guard !state.isLoading, state.canLoadMore else { return .none }
                state.isLoading = true
                state.page += 1
                let query = state.searchQuery
                let page = state.page
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, page) }))
                }

            case let .searchQueryChanged(query):
                state.searchQuery = query
                state.page = 1
                state.items = []
                state.total = 0
                state.isLoading = true
                let fetchClosure = fetch
                return .run { [fetchClosure] send in
                    await send(.articlesResponse(Result { try await fetchClosure(query, 1) }))
                }

            case let .articlesResponse(.success((newItems, total))):
                state.isLoading = false
                state.total = total
                // If it's a new search (page == 1), reset the collection
                if state.page == 1 {
                    state.items = Array(newItems.prefix(100))
                } else {
                    // Ensure we never exceed 100 articles
                    let remaining = max(0, 100 - state.items.count)
                    if remaining > 0 {
                        state.items.append(contentsOf: newItems.prefix(remaining))
                    }
                }
                return .none

            case let .articlesResponse(.failure(err)):
                state.isLoading = false
                state.errorMessage = err.localizedDescription
                return .none
            }
        }
    }
}
