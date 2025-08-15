import CoreModels
import CoreNetworking

public struct RemoteArticlesDataSource: ArticlesDataSource, Sendable {
    private let api: any NewsAPIProtocol
    public init(api: any NewsAPIProtocol) { self.api = api }

    public func fetchArticles(query: String, page: Int) async throws -> ([Article], total: Int) {
        guard page >= 1 else { throw ArticlesRepoError.invalidPage }
        let cleaned = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let response = try await (cleaned.isEmpty
            ? api.everything(page: page)
            : api.search(query: cleaned, page: page)
        )
        return (response.articles ?? [], response.totalResults ?? 0)
    }
}

extension String {
    var isBlank: Bool { trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
