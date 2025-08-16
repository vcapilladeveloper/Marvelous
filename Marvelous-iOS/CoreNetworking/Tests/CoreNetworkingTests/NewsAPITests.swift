import XCTest
import CoreModels
@testable import CoreNetworking

/// Tests for `NewsAPI`.
///
/// The SUT is `NewsAPI`; `APIClient` and `URLSessionMock` are collaborators.
/// We avoid `setUp`/`tearDown` because each test needs a specific session
/// configuration (status, data, or injected error), so keeping setup inline
/// makes each scenario explicit and isolated.
final class NewsAPITests: XCTestCase {

    private func createMockSession(_ data: Data, statusCode: Int, mockError: Error? = nil) -> URLSessionMock {
        let dummyURL = URL(string: "https://example.com")!
        let resp = HTTPURLResponse(
            url: dummyURL,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!

        let session = URLSessionMock()
        session.mockData = data
        session.mockResponse = resp
        session.mockError = mockError
        return session
    }

    @discardableResult
    private func makeAPI(data: Data, status: Int, error: Error? = nil, apiKey: String = "TEST_KEY") -> (sut: NewsAPI, session: URLSessionMock) {
        let session = createMockSession(data, statusCode: status, mockError: error)
        let api = NewsAPI(apiKey: apiKey, client: APIClient(session: session))
        return (sut: api, session: session)
    }

    func testEverythingBuildsRequestAndParses() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.everything(page: 1)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 2)
        XCTAssertEqual(result.totalResults, 2)
        let first = result.articles?.first
        XCTAssertEqual(first?.title, "Breaking News Title")
        XCTAssertEqual(first?.author, "John Doe")
        XCTAssertEqual(first?.description, "This is a sample news description.")
        XCTAssertEqual(first?.url, "https://www.bbc.com/news/example-article")
        XCTAssertEqual(first?.urlToImage, "https://www.bbc.com/news/example-image.jpg")
        XCTAssertEqual(first?.publishedAt, "2025-08-13T09:00:00Z")
        XCTAssertEqual(first?.content, "This is a sample news content.")
        if let articles = result.articles, articles.count > 1 {
            let second = articles[1]
            XCTAssertEqual(second.title, "Another Breaking News")
            XCTAssertEqual(second.author, "Jane Doe")
            XCTAssertEqual(second.source?.name, "The Verge")
        }
    }

    func testEverythingHandlesNon200Status() async throws {
        let sample = "{}"
        let data = Data(sample.utf8)
        let (sut, _) = makeAPI(data: data, status: 500)

        do {
            _ = try await sut.everything(page: 1)
            XCTFail("Expected everything(page:) to throw on non-200 status")
        } catch {
            XCTAssertFalse(error is DecodingError, "Unexpected DecodingError for non-200 status: \(error)")
            XCTAssertFalse(error is URLError, "Unexpected URLError for non-200 status: \(error)")
            XCTAssertTrue(error is NetworkError, "Expected error type: \(error)")
        }
    }

    func testEverythingHandlesInvalidJSON() async throws {
        let invalid = "not-json"
        let data = Data(invalid.utf8)
        let (sut, _) = makeAPI(data: data, status: 200)

        do {
            _ = try await sut.everything(page: 1)
            XCTFail("Expected everything(page:) to throw on invalid JSON")
        } catch let netErr as NetworkError {
            XCTAssertTrue(true, "Expected NetworkError for invalid JSON, got: \(netErr)")
        } catch {
            XCTFail("Expected NetworkError for invalid JSON but got: \(error)")
        }
    }

    func testEverythingHandlesTransportError() async throws {
        let data = Data()

        let (sut, _) = makeAPI(data: data, status: 200, error: URLError(.notConnectedToInternet))

        do {
            _ = try await sut.everything(page: 1)
            XCTFail("Expected everything(page:) to throw on transport error")
        } catch {
            if let urlError = error as? URLError {
                XCTAssertEqual(urlError.code, .notConnectedToInternet)
            } else {
                XCTFail("Expected URLError but got: \(error)")
            }
        }
    }

    func testMockJSONStringDecodesToMock() throws {
        let data = Data(NewsAPIResponse.mockJSONString.utf8)
        let decoded = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        XCTAssertEqual(decoded, .mock)
    }

    func testSearchBuildsRequestAndParses() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.search(query: "technology", page: 1)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 2)
        XCTAssertEqual(result.totalResults, 2)
    }

    func testSearchWithEmptyQuery() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.search(query: "", page: 1)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 2)
    }

    func testSearchWithSpecialCharacters() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.search(query: "AI & Machine Learning", page: 1)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 2)
    }

    func testSearchWithLongQuery() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let longQuery = String(repeating: "a", count: 1000)
        let result = try await sut.search(query: longQuery, page: 1)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 2)
    }

    func testEverythingWithDifferentPages() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result1 = try await sut.everything(page: 1)
        XCTAssertEqual(result1.status, "ok")

        let result2 = try await sut.everything(page: 5)
        XCTAssertEqual(result2.status, "ok")

        let result3 = try await sut.everything(page: 100)
        XCTAssertEqual(result3.status, "ok")
    }

    func testSearchWithDifferentPages() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result1 = try await sut.search(query: "tech", page: 1)
        XCTAssertEqual(result1.status, "ok")

        let result2 = try await sut.search(query: "tech", page: 10)
        XCTAssertEqual(result2.status, "ok")
    }

    func testEverythingWithDefaultPage() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.everything()
        XCTAssertEqual(result.status, "ok")
    }

    func testSearchWithDefaultPage() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let (sut, _) = makeAPI(data: data, status: 200)

        let result = try await sut.search(query: "technology")
        XCTAssertEqual(result.status, "ok")
    }

    func testAPIKeyIsSetInRequest() async throws {
        let sample = NewsAPIResponse.mockJSONString
        let data = Data(sample.utf8)

        let apiKey = "TEST_API_KEY_123"
        let (sut, _) = makeAPI(data: data, status: 200, apiKey: apiKey)

        let result = try await sut.everything(page: 1)
        XCTAssertEqual(result.status, "ok")
    }
}
