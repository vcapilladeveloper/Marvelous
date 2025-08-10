import Foundation
import CoreModels

public struct FetchHeroesUseCase: Sendable {
    private let repository: HeroesRepository

    public init(repository: HeroesRepository) {
        self.repository = repository
    }

    public func execute(limit: Int, offset: Int, query: String?) async throws -> [Hero] {
        try await repository.fetchHeroes(limit: limit, offset: offset, query: query)
    }
}
