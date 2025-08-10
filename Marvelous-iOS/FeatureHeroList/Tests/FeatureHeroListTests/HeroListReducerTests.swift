import XCTest
import ComposableArchitecture
import CoreModels
@testable import FeatureHeroList

final class HeroListReducerTests: XCTestCase {
    /// Why I have no XCTAssert here?
    func testOnAppearLoadsHeroes() async {
        let store = await TestStore(initialState: HeroListFeature.State()) {
            HeroListFeature()
        } withDependencies: {
            $0.fetchHeroesUseCase = FetchHeroesUseCase(repository: MockRepo())
        }

        await store.send(.onAppear) {
            $0.isLoading = true
            $0.errorMessage = nil
        }
        await store.receive(\.heroesResponse.success) {
            $0.isLoading = false
            $0.heroes = [Hero.fixture()]
        }
    }
}

private struct MockRepo: HeroesRepository {
    func fetchHeroes(limit: Int, offset: Int, query: String?) async throws -> [Hero] {
        [Hero.fixture()]
    }
}

/// In order to not make public inits for Hero an all the dependant models, I initialized a hero from JSON.
private extension Hero {
    static func fixture(
        id: Int = 1,
        name: String = "Mock Hero",
        description: String = ""
    ) -> Hero {
        let json = """
        {
            "id": \(id),
            "name": "\(name)",
            "description": "\(description)",
            "thumbnail": { "path": "https://example.com/image", "extension": "jpg" },
            "resourceURI": "https://example.com/resource",
            "comics": { "available": 0, "items": [] },
            "series": { "available": 0, "items": [] },
            "stories": { "available": 0, "items": [] },
            "events": { "available": 0, "items": [] }
        }
        """
        let data = Data(json.utf8)
        // swiftlint:disable force_try
        return try! JSONDecoder().decode(Hero.self, from: data)
        // swiftlint:enable force_try
    }
}
