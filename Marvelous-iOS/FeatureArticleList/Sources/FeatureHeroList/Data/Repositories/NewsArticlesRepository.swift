import CoreModels
import CoreNetworking

public struct NewsArticlesRepository: ArticlesRepository, Sendable {
    private let api: NewsAPI
    public init(api: NewsAPI) { self.api = api }
    public func fetchArticles(query: String, page: Int, pageSize: Int) async throws -> ([Article], total: Int) {
        let res = try await api.everything(query: query, page: page, pageSize: pageSize)
        return (res.articles ?? [], res.totalResults ?? 0)
    }
}
