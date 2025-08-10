import Foundation
import CoreModels

public struct NewsAPI: Sendable {
    private let base = URL(string: "https://newsapi.org/v2")
    private let apiKey: String
    private let client: any APIRequestable

    public init(apiKey: String, client: any APIRequestable) {
        self.apiKey = apiKey
        self.client = client
    }

    public func everything(
        query: String,
        page: Int = 1,
        pageSize: Int = 20,
        language: String? = "en",
        sortBy: String? = nil // "relevancy" | "popularity" | "publishedAt"
    ) async throws -> NewsAPIResponse {
        guard let base, let compsBase = URLComponents(url: base.appending(path: "everything"), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        var comps = compsBase
        var items: [URLQueryItem] = [
            .init(name: "q", value: query),
            .init(name: "page", value: String(max(1, page))),
            .init(name: "pageSize", value: String(min(100, max(1, pageSize))))
        ]
        if let language { items.append(.init(name: "language", value: language)) }
        if let sortBy { items.append(.init(name: "sortBy", value: sortBy)) }
        comps.queryItems = items

        guard let url = comps.url else { throw NetworkError.invalidURL }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        req.httpMethod = "GET"
        return try await client.fetch(NewsAPIResponse.self, from: req)
    }
}
