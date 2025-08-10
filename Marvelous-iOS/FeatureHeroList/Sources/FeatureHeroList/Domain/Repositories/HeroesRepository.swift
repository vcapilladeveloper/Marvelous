import Foundation
import CoreModels

public protocol HeroesRepository: Sendable {
    func fetchHeroes(limit: Int, offset: Int, query: String?) async throws -> [Hero]
}
