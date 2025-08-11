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
        page: Int = 1
    ) async throws -> NewsAPIResponse {
        guard let base, let compsBase = URLComponents(url: base.appending(path: "everything"), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        var comps = compsBase
        let items: [URLQueryItem] = [
            .init(name: "page", value: String(page)),
            .init(name: "pageSize", value: "20"),
            .init(name: "language", value: "en"),
            .init(name: "domains", value: "techcrunch.com")
        ]

        comps.queryItems = items

        guard let url = comps.url else { throw NetworkError.invalidURL }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        req.httpMethod = "GET"
        return try await client.fetch(NewsAPIResponse.self, from: req)
    }

    public func search(
        query: String,
        page: Int = 1
    ) async throws -> NewsAPIResponse {
        guard let base, let compsBase = URLComponents(url: base.appending(path: "everything"), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        var comps = compsBase
        let items: [URLQueryItem] = [
            .init(name: "q", value: query),
            .init(name: "page", value: String(page)),
            .init(name: "pageSize", value: "20"),
            .init(name: "language", value: "en"),
            .init(name: "domains", value: "techcrunch.com")
        ]

        comps.queryItems = items

        guard let url = comps.url else { throw NetworkError.invalidURL }
        var req = URLRequest(url: url)
        req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        req.httpMethod = "GET"
        return try await client.fetch(NewsAPIResponse.self, from: req)
    }
}
