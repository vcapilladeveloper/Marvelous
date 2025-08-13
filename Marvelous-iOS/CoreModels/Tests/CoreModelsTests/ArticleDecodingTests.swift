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

    func testDecodeArticleWithMissingOptionalFields() throws {
        let json = """
        {
          "status": "ok",
          "totalResults": 1,
          "articles": [{
            "source": {"id": "the-verge", "name": "The Verge"},
            "title": "Sample Title"
          }]
        }
        """
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        let article = decoded.articles?.first

        XCTAssertNotNil(article)
        XCTAssertEqual(article?.title, "Sample Title")
        XCTAssertNil(article?.author)
        XCTAssertNil(article?.description)
        XCTAssertNil(article?.url)
        XCTAssertNil(article?.urlToImage)
        XCTAssertNil(article?.publishedAt)
        XCTAssertNil(article?.content)
    }

    func testDecodeSourceWithMissingFields() throws {
        let json = """
        {
          "status": "ok",
          "totalResults": 1,
          "articles": [{
            "source": {"id": "the-verge"},
            "title": "Sample Title"
          }]
        }
        """
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        let source = decoded.articles?.first?.source

        XCTAssertNotNil(source)
        XCTAssertEqual(source?.id, "the-verge")
        XCTAssertNil(source?.name)
    }

    func testArticleComputedProperties() {
        let article = Article(
            source: Source(id: "test", name: "Test Source"),
            author: "Test Author",
            title: "Test Title",
            description: "Test Description",
            url: "https://example.com/article",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: "2025-08-10T12:00:00Z",
            content: "Test Content"
        )

        XCTAssertEqual(article.id, "https://example.com/article")
        XCTAssertEqual(article.imageURL?.absoluteString, "https://example.com/image.jpg")
        XCTAssertEqual(article.webURL?.absoluteString, "https://example.com/article")
    }

    func testArticleIDGenerationWhenURLIsNil() {
        let article = Article(
            source: nil,
            author: nil,
            title: nil,
            description: nil,
            url: nil,
            urlToImage: nil,
            publishedAt: nil,
            content: nil
        )

        XCTAssertNotNil(article.id)
        XCTAssertTrue(article.id.isEmpty == false)
    }

    func testArticleWithInvalidURLs() {
        let article = Article(
            source: nil,
            author: nil,
            title: nil,
            description: nil,
            url: "ht!tp:// example .com",
            urlToImage: "ht!tp:// example .com",
            publishedAt: nil,
            content: nil
        )

        XCTAssertNil(article.webURL)
        XCTAssertNil(article.imageURL)
    }

    func testNewsAPIResponseEquality() {
        let response1 = NewsAPIResponse(
            status: "ok",
            totalResults: 10,
            articles: [Article.mock]
        )

        let response2 = NewsAPIResponse(
            status: "ok",
            totalResults: 10,
            articles: [Article.mock]
        )

        XCTAssertEqual(response1, response2)
    }

    func testArticleEquality() {
        let article1 = Article.mock
        let article2 = Article.mock

        XCTAssertEqual(article1, article2)
    }

    func testSourceEquality() {
        let source1 = Source(id: "test", name: "Test")
        let source2 = Source(id: "test", name: "Test")

        XCTAssertEqual(source1, source2)
    }

    func testMockDataConsistency() {
        let mock = NewsAPIResponse.mock
        XCTAssertEqual(mock.status, "ok")
        XCTAssertEqual(mock.totalResults, 2)
        XCTAssertEqual(mock.articles?.count, 2)

        let firstArticle = mock.articles?.first
        XCTAssertEqual(firstArticle?.title, "Breaking News Title")
        XCTAssertEqual(firstArticle?.author, "John Doe")
        XCTAssertEqual(firstArticle?.source?.name, "BBC News")
    }
}
