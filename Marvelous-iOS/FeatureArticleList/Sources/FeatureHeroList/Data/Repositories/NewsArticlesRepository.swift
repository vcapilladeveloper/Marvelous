import CoreModels
import CoreNetworking

public struct NewsArticlesRepository: ArticlesRepository, Sendable {
    private let api: NewsAPI
    public init(api: NewsAPI) { self.api = api }


    public func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int) {
        let response = try await (
            query.isBlank
            ? api.everything(page: page)
            : api.search(query: query.trimmingCharacters(in: .whitespacesAndNewlines), page: page)
        )
        return (response.articles ?? [], response.totalResults ?? 0)
    }
}
extension String {
    var isBlank: Bool { trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
