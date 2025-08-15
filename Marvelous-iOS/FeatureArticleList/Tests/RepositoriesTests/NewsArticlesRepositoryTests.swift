import XCTest
import CoreModels
@testable import FeatureArticleList

struct ArticlesDataSourceMock: ArticlesDataSource, Sendable {
    let handler: @Sendable (_ query: String, _ page: Int) async throws -> ([Article], total: Int)
    func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int) {
        try await handler(query, page)
    }
}

final class NewsArticlesRepositoryTests: XCTestCase {

    func testDelegatesToDataSource() async throws {
        let expected = [Article.mock, Article.mock]
        let dataSource = ArticlesDataSourceMock { query, page in
            XCTAssertEqual(query, "swift")
            XCTAssertEqual(page, 3)
            return (expected, expected.count)
        }
        let repo = NewsArticlesRepository(remote: dataSource)

        let (items, total) = try await repo.fetchArticles(query: "swift", page: 3)

        XCTAssertEqual(items, expected)
        XCTAssertEqual(total, expected.count)
    }

    func testGuardsInvalidPage() async {
        let dataSoruce = ArticlesDataSourceMock { _, _ in fatalError("Should not be called") }
        let repo = NewsArticlesRepository(remote: dataSoruce)

        do {
            _ = try await repo.fetchArticles(query: "swift", page: 0)
            XCTFail("Expected invalid page to throw")
        } catch {
            
        }
    }
}
