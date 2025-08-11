import CoreModels

public protocol ArticlesRepository: Sendable {
    func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int)
}
