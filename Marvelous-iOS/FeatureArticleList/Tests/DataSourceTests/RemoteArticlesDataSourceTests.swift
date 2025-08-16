import XCTest
import CoreModels
import CoreNetworking
@testable import FeatureArticleList

@MainActor
final class RemoteArticlesDataSourceTests: XCTestCase {

    /// These tests intentionally avoid using `setUp` and `tearDown`.
    /// Each test case creates its own `NewsAPIMock` and `RemoteArticlesDataSource`,
    /// keeping initialization explicit and localized. This makes the tests easier
    /// to read and ensures that the state under test is fully visible within
    /// each individual test.
    
    func testBlankQueryCallsEverything() async throws {
        let api = NewsAPIMock(
            everythingHandler: { page in
                XCTAssertEqual(page, 2)
                return .init(status: "", totalResults: 1, articles: [Article.mock])
            }
        )
        let sut = RemoteArticlesDataSource(api: api)

        let (items, total) = try await sut.fetchArticles(query: "   ", page: 2)

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(total, 1)
    }

    func testNonBlankQueryCallsSearchWithTrimmedQuery() async throws {
        let api = NewsAPIMock(
            searchHandler: { query, page in
                XCTAssertEqual(query, "swift")
                XCTAssertEqual(page, 1)
                return .init(status: "", totalResults: 42, articles: [Article.mock, Article.mock])
            }
        )
        let sut = RemoteArticlesDataSource(api: api)

        let (items, total) = try await sut.fetchArticles(query: "  swift  ", page: 1)

        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(total, 42)
    }

    func testMapsNilOptionalsToEmptyAndZero() async throws {
        let api = NewsAPIMock(
            everythingHandler: { _ in
                    .init(status: "", totalResults: nil, articles: nil)
            }
        )
        let sut = RemoteArticlesDataSource(api: api)

        let (items, total) = try await sut.fetchArticles(query: "", page: 1)

        XCTAssertEqual(items, [])
        XCTAssertEqual(total, 0)
    }

    func testPropagatesErrors() async {
        struct CriticalError: Error {}
        let api = NewsAPIMock(
            everythingHandler: { _ in throw CriticalError() }
        )
        let sut = RemoteArticlesDataSource(api: api)

        do {
            _ = try await sut.fetchArticles(query: "", page: 1)
            XCTFail("Expected to throw CriticalError")
        } catch {
            XCTAssertTrue(error is CriticalError)
        }
    }
}

struct NewsAPIMock: NewsAPIProtocol, Sendable {
    var everythingHandler: @Sendable (_ page: Int) async throws -> NewsAPIResponse
    var searchHandler: @Sendable (_ query: String, _ page: Int) async throws -> NewsAPIResponse

    init(
        everythingHandler: @escaping @Sendable (Int) async throws ->
            NewsAPIResponse = { _ in
                .init(status: "", totalResults: 0, articles: [])
            },
        searchHandler: @escaping @Sendable (String, Int) async throws ->
            NewsAPIResponse = { _, _ in
                .init(status: "", totalResults: 0, articles: [])
            }
    ) {
        self.everythingHandler = everythingHandler
        self.searchHandler = searchHandler
    }

    func everything(page: Int) async throws -> NewsAPIResponse {
        try await everythingHandler(page)
    }

    func search(query: String, page: Int) async throws -> NewsAPIResponse {
        try await searchHandler(query, page)
    }
}
