import ComposableArchitecture
import CoreModels
import CoreNetworking

public struct ArticleListFeature: Reducer {
    public init() {}
    public struct State: Equatable, Sendable {
        public var items: [Article] = []
        public var isLoading = false
        public var errorMessage: String?
        public var searchQuery: String = ""
        public var page = 1
        public var total = 0
        public var selected: Article?
        public init() {}
    /// Only allow loading more if we have less than both the API total and 100 articles
    public var canLoadMore: Bool { items.count < min(total, 100) }
    }

    public struct ArticlesResponse: Equatable, Sendable {
        public let articles: [Article]
        public let total: Int

        public init(articles: [Article], total: Int) {
            self.articles = articles
            self.total = total
        }
    }

    public enum Action: Sendable {
        case onAppear
        case loadMore
        case searchQueryChanged(String)
        case retry
        case articlesResponseSuccess(ArticlesResponse)
        case articlesResponseFailure(NetworkError)
        case didSelect(Article)
        case dismissDetail
    }

    @Dependency(\.fetchArticlesUseCase) var fetch

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.items.isEmpty else { return .none }
                state.isLoading = true
                let query = state.searchQuery
                let page = state.page
                let fetch = fetch
                return .run { [fetch] send in
                    do {
                        let value = try await fetch.execute(query: query, page: page)
                        await send(.articlesResponseSuccess(ArticlesResponse(articles: value.0, total: value.1)))
                    } catch let error as NetworkError {
                        await send(.articlesResponseFailure(error))
                    } catch {
                        await send(.articlesResponseFailure(.unknown(error)))
                    }
                }

            case .retry:
                state.items = []
                state.page = 1
                state.total = 0
                state.errorMessage = nil
                state.isLoading = true
                let query = state.searchQuery
                let fetch = fetch
                return .run { [fetch] send in
                    do {
                        let value = try await fetch.execute(query: query, page: 1)
                        await send(.articlesResponseSuccess(ArticlesResponse(articles: value.0, total: value.1)))
                    } catch let error as NetworkError {
                        await send(.articlesResponseFailure(error))
                    } catch {
                        await send(.articlesResponseFailure(.unknown(error)))
                    }
                }

            case .loadMore:
                guard !state.isLoading, state.canLoadMore else { return .none }
                state.isLoading = true
                state.page += 1
                let query = state.searchQuery
                let page = state.page
                let fetch = fetch
                return .run { [fetch] send in
                    do {
                        let value = try await fetch.execute(query: query, page: page)
                        await send(.articlesResponseSuccess(ArticlesResponse(articles: value.0, total: value.1)))
                    } catch let error as NetworkError {
                        await send(.articlesResponseFailure(error))
                    } catch {
                        await send(.articlesResponseFailure(.unknown(error)))
                    }
                }

            case let .searchQueryChanged(query):
                state.searchQuery = query
                state.page = 1
                state.items = []
                state.total = 0
                state.isLoading = true
                let fetch = fetch
                return .run { [fetch] send in
                    do {
                        let value = try await fetch.execute(query: query, page: 1)
                        await send(.articlesResponseSuccess(ArticlesResponse(articles: value.0, total: value.1)))
                    } catch let error as NetworkError {
                        await send(.articlesResponseFailure(error))
                    } catch {
                        await send(.articlesResponseFailure(.unknown(error)))
                    }
                }

            case let .articlesResponseSuccess(response):
                state.isLoading = false
                state.total = response.total
                if state.page == 1 {
                    state.items = Array(response.articles.prefix(100))
                } else {
                    let remaining = max(0, 100 - state.items.count)
                    if remaining > 0 {
                        state.items.append(contentsOf: response.articles.prefix(remaining))
                    }
                }
                return .none

            case let .articlesResponseFailure(err):
                state.isLoading = false
                state.errorMessage = err.localizedDescription
                return .none

            case let .didSelect(article):
                state.selected = article
                return .none

            case .dismissDetail:
                state.selected = nil
                return .none
            }
        }
    }
}
