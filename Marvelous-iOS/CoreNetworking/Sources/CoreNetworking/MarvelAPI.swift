import Foundation
import CoreModels

public struct MarvelAPI: Sendable {
    private let baseURL = "https://gateway.marvel.com/v1/public"
    private let publicKey: String
    private let privateKey: String
    private let apiClient: any APIRequestable

    public init(publicKey: String, privateKey: String, apiClient: any APIRequestable) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.apiClient = apiClient
    }

    // Already existing method
    public func getCharacters(limit: Int, offset: Int) async throws -> APIResponse<Hero> {
        let url = try buildURL(
            endpoint: "/characters",
            queryItems: [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
        )
        return try await apiClient.fetch(APIResponse<Hero>.self, from: url)
    }

    // New method for search
    public func searchCharacters(
        nameStartsWith: String,
        limit: Int,
        offset: Int
    ) async throws -> APIResponse<Hero> {
        let url = try buildURL(
            endpoint: "/characters",
            queryItems: [
                URLQueryItem(name: "nameStartsWith", value: nameStartsWith),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
        )
        return try await apiClient.fetch(APIResponse<Hero>.self, from: url)
    }

    // Shared URL builder
    private func buildURL(endpoint: String, queryItems: [URLQueryItem]) throws -> URL {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = queryItems + [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        return url
    }
}
