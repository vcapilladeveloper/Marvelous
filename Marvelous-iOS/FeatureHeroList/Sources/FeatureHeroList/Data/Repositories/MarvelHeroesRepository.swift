import Foundation
import CoreModels
import CoreNetworking

public final class MarvelHeroesRepository: HeroesRepository, Sendable {
    private let marvelAPI: MarvelAPI

    public init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }

    public func fetchHeroes(limit: Int, offset: Int, query: String?) async throws -> [Hero] {
        let response: APIResponse<Hero>
        if let query, !query.isEmpty {
            response = try await marvelAPI.searchCharacters(nameStartsWith: query, limit: limit, offset: offset)
        } else {
            response = try await marvelAPI.getCharacters(limit: limit, offset: offset)
        }
        return response.data.results
    }
}
