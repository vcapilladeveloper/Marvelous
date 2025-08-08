import XCTest
@testable import CoreModels

final class HeroDecodingTests: XCTestCase {
    
    func testHeroDecoding() throws {
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
                        "comics": {
                            "available": 12,
                            "items": [
                                { "resourceURI": "http://gateway.marvel.com/v1/public/comics/21366", "name": "Avengers: The Initiative (2007) #14" }
                            ]
                        },
                        "series": {
                            "available": 3,
                            "items": [
                                { "resourceURI": "http://gateway.marvel.com/v1/public/series/1945", "name": "Avengers: The Initiative (2007 - 2010)" }
                            ]
                        },
                        "stories": {
                            "available": 1,
                            "items": [
                                { "resourceURI": "http://gateway.marvel.com/v1/public/stories/19947", "name": "Cover #19947", "type": "cover" }
                            ]
                        },
                        "events": {
                            "available": 1,
                            "items": [
                                { "resourceURI": "http://gateway.marvel.com/v1/public/events/269", "name": "Secret Invasion" }
                            ]
                        }
                    }
                ]
            }
        }
        """
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(APIResponse<Hero>.self, from: data)
        
        XCTAssertEqual(decoded.code, 200)
        XCTAssertEqual(decoded.data.results.count, 1)
        XCTAssertEqual(decoded.data.results.first?.name, "3-D Man")
        XCTAssertEqual(decoded.data.results.first?.thumbnail.url?.absoluteString, "https://i.annihil.us/u/prod/marvel/i/mg/6/70/52602f21f29ec.jpg")
    }
}
