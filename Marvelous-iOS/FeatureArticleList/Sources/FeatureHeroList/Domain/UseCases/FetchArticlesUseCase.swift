import CoreModels

public struct FetchArticlesUseCase: Sendable {
    private let repo: any ArticlesRepository
    public init(repo: any ArticlesRepository) { self.repo = repo }
    public func execute(query: String, page: Int) async throws -> ([Article], total: Int) {
        try await repo.fetchArticles(query: query, page: page)
    }
}
