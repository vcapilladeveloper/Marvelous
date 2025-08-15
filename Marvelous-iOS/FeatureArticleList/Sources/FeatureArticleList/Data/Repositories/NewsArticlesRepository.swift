import CoreModels
import CoreNetworking

enum ArticlesRepoError: Error { case invalidPage }
public struct NewsArticlesRepository: ArticlesRepository, Sendable {
    private let remote: any ArticlesDataSource

    public init(remote: any ArticlesDataSource) {
        self.remote = remote
    }

    public func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int) {
        guard page >= 1 else { throw ArticlesRepoError.invalidPage }
        return try await remote.fetchArticles(query: query, page: page)
    }
}
