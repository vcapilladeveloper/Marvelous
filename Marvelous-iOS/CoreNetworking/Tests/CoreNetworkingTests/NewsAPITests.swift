import XCTest
import CoreModels
@testable import CoreNetworking

final class NewsAPITests: XCTestCase {
    func testEverythingBuildsRequestAndParses() async throws {
        let sample = """
        { "status":"ok", "totalResults":1,
          "articles":[{"title":"Hello","url":"https://ex.com","urlToImage":"https://ex.com/img.jpg"}]
        }
        """
        let data = Data(sample.utf8)
        guard let dummyURL = URL(string: "https://example.com"),
            let resp = HTTPURLResponse(
                url: dummyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        else {
            XCTFail("Failed to create dummy URL or response")
            return
        }

        let session = URLSessionMock(data: data, response: resp, error: nil)

        let api = NewsAPI(apiKey: "TEST_KEY", client: APIClient(session: session))
        let result = try await api.everything(query: "apple", page: 1, pageSize: 20)
        XCTAssertEqual(result.status, "ok")
        XCTAssertEqual(result.articles?.count, 1)
        XCTAssertEqual(result.articles?.first?.title, "Hello")
    }
}
