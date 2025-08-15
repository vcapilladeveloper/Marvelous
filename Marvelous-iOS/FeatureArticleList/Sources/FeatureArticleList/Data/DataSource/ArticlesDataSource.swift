import CoreModels

public protocol ArticlesDataSource: Sendable {
    func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int)
}
