import Foundation

public struct NewsAPIResponse: Decodable, Sendable, Equatable {
    public let status: String           // "ok" or "error"
    public let totalResults: Int?
    public let articles: [Article]?
    // When status == "error", the API returns code+message; you can extend to capture that.
}

public struct Article: Decodable, Identifiable, Sendable, Equatable {
    public var id: String { url ?? UUID().uuidString } // stable enough for UI lists
    public let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?

    public var imageURL: URL? { URL(string: urlToImage ?? "") }
    public var webURL: URL? { URL(string: url ?? "") }
}

public struct Source: Decodable, Sendable, Equatable {
    public let id: String?
    public let name: String?
}
