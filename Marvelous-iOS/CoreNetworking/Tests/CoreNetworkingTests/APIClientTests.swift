import XCTest
@testable import CoreNetworking
@testable import CoreModels

final class APIClientTests: XCTestCase {
    func testFetchDecodesCorrectly() async throws {
        let json = """
        {
            "code": 200,
            "status": "Ok",
            "data": {
                "offset": 0,
                "limit": 1,
                "total": 1,
                "count": 1,
                "results": [
                    {
                        "id": 1011334,
                        "name": "3-D Man",
                        "description": "Some description",
                        "thumbnail": {
                            "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/52602f21f29ec",
                            "extension": "jpg"
                        },
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
                        "comics": { "available": 0, "items": [] },
                        "series": { "available": 0, "items": [] },
                        "stories": { "available": 0, "items": [] },
                        "events": { "available": 0, "items": [] }
                    }
                ]
            }
        }
        """
        let data = Data(json.utf8)
        let url = URL(string: "https://example.com")!

        let mockSession = URLSessionMock(
            data: data,
            response: HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!,
            error: nil
        )

        let client = APIClient(session: mockSession)
        let response = try await client.fetch(APIResponse<Hero>.self, from: url)

        XCTAssertEqual(response.data.results.first?.name, "3-D Man")
    }
}
