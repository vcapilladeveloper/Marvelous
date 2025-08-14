import XCTest
import CoreModels
import CoreNetworking
import ComposableArchitecture
@testable import FeatureArticleList

@MainActor
final class FeatureArticleListTests: XCTestCase {
    private struct ArticlesRepositoryMock: ArticlesRepository, Sendable {
        let handler: @Sendable (String, Int) async throws -> ([Article], total: Int)
        func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int) {
            try await handler(query, page)
        }
    }

    private func makeArticles(_ count: Int) -> [Article] {
        Array(repeating: .mock, count: count)
    }

    func testFetchArticlesSuccess() async throws {
        let mockArticles = [
            Article.mock,
            Article.mock,
            Article.mock
        ]

        let useCaseMock = FetchArticlesUseCase(
            repo: ArticlesRepositoryMock(handler: { _, _ in
                (mockArticles, mockArticles.count)
            })
        )

        let store = TestStore(
            initialState: ArticleListFeature.State(),
            reducer: {  ArticleListFeature() }
        ) {
            $0.fetchArticlesUseCase = useCaseMock
        }

        await store.send(.onAppear) {
            $0.isLoading = true
        }

        let response = ArticleListFeature.ArticlesResponse(articles: mockArticles, total: mockArticles.count)
        await store.receive(ArticleListFeature.Action.articlesResponseSuccess(response)) {
            $0.isLoading = false
            $0.items = mockArticles
            $0.total = mockArticles.count
        }
    }

    func testOnAppearFailureSetsError() async {
        let useCaseMock = FetchArticlesUseCase(
            repo: ArticlesRepositoryMock(handler: { _, _ in
                throw NetworkError.requestFailed(statusCode: 500)
            })
        )

        let store = TestStore(
            initialState: ArticleListFeature.State(),
            reducer: { ArticleListFeature() }
        ) {
            $0.fetchArticlesUseCase = useCaseMock
        }

        await store.send(.onAppear) { state in
            state.isLoading = true
        }

        await store.receive(.articlesResponseFailure(.requestFailed(statusCode: 500))) { state in
            state.isLoading = false
            state.errorMessage = NetworkError.requestFailed(statusCode: 500).localizedDescription
        }
    }

    func testRetryResetsAndFetches() async {
        let returned = makeArticles(3)
        let useCaseMock = FetchArticlesUseCase(
            repo: ArticlesRepositoryMock(handler: { _, _ in (returned, returned.count) })
        )

        var initial = ArticleListFeature.State()
        initial.items = makeArticles(2)
        initial.page = 3
        initial.total = 10
        initial.errorMessage = "Boom"

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) {
            $0.fetchArticlesUseCase = useCaseMock
        }

        await store.send(.retry) { state in
            state.items = []
            state.page = 1
            state.total = 0
            state.errorMessage = nil
            state.isLoading = true
        }

        let response = ArticleListFeature.ArticlesResponse(articles: returned, total: returned.count)
        await store.receive(.articlesResponseSuccess(response)) { state in
            state.isLoading = false
            state.items = returned
            state.total = returned.count
        }
    }

    func testLoadMoreSuccessAppends() async {
        let initialItems = makeArticles(2)
        let nextPageItems = makeArticles(3)

        let useCaseMock = FetchArticlesUseCase(
            repo: ArticlesRepositoryMock(handler: { _, page in
                XCTAssertEqual(page, 2)
                return (nextPageItems, nextPageItems.count)
            })
        )

        var initial = ArticleListFeature.State()
        initial.items = initialItems
        initial.total = 10
        initial.page = 1
        initial.isLoading = false

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) {
            $0.fetchArticlesUseCase = useCaseMock
        }

        await store.send(.loadMore) { state in
            state.isLoading = true
            state.page = 2
        }

        let response = ArticleListFeature.ArticlesResponse(articles: nextPageItems, total: nextPageItems.count)
        await store.receive(.articlesResponseSuccess(response)) { state in
            state.isLoading = false
            state.total = nextPageItems.count
            state.items = initialItems + nextPageItems
        }
    }

    func testLoadMoreIgnoredWhenAlreadyLoading() async {
        var initial = ArticleListFeature.State()
        initial.items = makeArticles(2)
        initial.total = 10
        initial.page = 1
        initial.isLoading = true

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) { _ in }

        await store.send(.loadMore)
    }

    func testLoadMoreIgnoredWhenCannotLoadMore() async {
        var initial = ArticleListFeature.State()
        initial.items = makeArticles(5)
        initial.total = 5 // equal to items, so canLoadMore == false
        initial.page = 1
        initial.isLoading = false

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) { _ in }

        await store.send(.loadMore)
    }

    func testSearchQueryChangedResetsAndFetches() async {
        let returned = makeArticles(4)
        let useCaseMock = FetchArticlesUseCase(
            repo: ArticlesRepositoryMock(handler: { query, page in
                XCTAssertEqual(query, "swift")
                XCTAssertEqual(page, 1)
                return (returned, returned.count)
            })
        )

        var initial = ArticleListFeature.State()
        initial.items = makeArticles(2)
        initial.total = 9
        initial.page = 3

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) {
            $0.fetchArticlesUseCase = useCaseMock
        }

        await store.send(.searchQueryChanged("swift")) { state in
            state.searchQuery = "swift"
            state.page = 1
            state.items = []
            state.total = 0
            state.isLoading = true
        }

        let response = ArticleListFeature.ArticlesResponse(articles: returned, total: returned.count)
        await store.receive(.articlesResponseSuccess(response)) { state in
            state.isLoading = false
            state.items = returned
            state.total = returned.count
        }
    }

    func testArticlesResponseSuccessFirstPageReplaces() async {
        var initial = ArticleListFeature.State()
        initial.page = 1
        initial.isLoading = true

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) { _ in }

        let fresh = makeArticles(3)
        let response = ArticleListFeature.ArticlesResponse(articles: fresh, total: fresh.count)
        await store.send(.articlesResponseSuccess(response)) { state in
            state.isLoading = false
            state.total = fresh.count
            state.items = fresh
        }
    }

    func testArticlesResponseSuccessLoadMoreCappedAt100() async {
        var initial = ArticleListFeature.State()
        initial.page = 2 // simulate we already incremented for pagination
        initial.items = makeArticles(98)
        initial.isLoading = true

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) { _ in }

        let incoming = makeArticles(10)
        let response = ArticleListFeature.ArticlesResponse(articles: incoming, total: 200)
        await store.send(.articlesResponseSuccess(response)) { [weak self] state in
            guard let self = self else { return }
            state.isLoading = false
            state.total = 200
            state.items = self.makeArticles(100)
        }
    }

    func testArticlesResponseFailureSetsError() async {
        var initial = ArticleListFeature.State()
        initial.isLoading = true

        let store = TestStore(initialState: initial, reducer: { ArticleListFeature() }) { _ in }

        await store.send(.articlesResponseFailure(.invalidURL)) { state in
            state.isLoading = false
            state.errorMessage = NetworkError.invalidURL.localizedDescription
        }
    }

    func testDidSelectAndDismissDetail() async {
        let article = Article.mock
        let store = TestStore(
            initialState: ArticleListFeature.State(),
            reducer: { ArticleListFeature() }
        ) { _ in }

        await store.send(.didSelect(article)) { state in
            state.selected = article
        }

        await store.send(.dismissDetail) { state in
            state.selected = nil
        }
    }
}
