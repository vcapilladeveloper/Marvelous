import XCTest
@testable import CoreModels

final class ArticleDecodingTests: XCTestCase {
    func testDecodeArticles() throws {
        let json = """
        {
          "status": "ok",
          "totalResults": 1,
          "articles": [{
            "source": {"id": "the-verge", "title": "The Verge"},
            "author": "Jane Doe",
            "title": "Sample Title",
            "description": "Short desc",
            "url": "https://example.com/article",
            "urlToImage": "https://example.com/image.jpg",
            "publishedAt": "2025-08-10T12:00:00Z",
            "content": "Full content"
          }]
        }
        """
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        XCTAssertEqual(decoded.status, "ok")
        XCTAssertEqual(decoded.totalResults, 1)
        XCTAssertEqual(decoded.articles?.first?.title, "Sample Title")
    }
}
