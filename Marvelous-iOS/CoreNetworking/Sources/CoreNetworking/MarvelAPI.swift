import Foundation
import CoreModels

public struct MarvelAPI {
    private let baseURL = "https://gateway.marvel.com/v1/public"
    private let publicKey: String
    private let privateKey: String
    private let apiClient: APIRequestable

    public init(publicKey: String, privateKey: String, apiClient: APIRequestable) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.apiClient = apiClient
    }

    private func authQueryItems() -> [URLQueryItem] {
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let privateKey = privateKey
        let publicKey = publicKey
        return [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: "\(timestamp)\(privateKey)\(publicKey)".md5)
        ]
    }

    public func getCharacters(limit: Int = 20, offset: Int = 0) async throws -> APIResponse<Hero> {
        var components = URLComponents(string: "\(baseURL)/characters")!
        components.queryItems = authQueryItems() + [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        return try await apiClient.fetch(APIResponse<Hero>.self, from: url)
    }
}
