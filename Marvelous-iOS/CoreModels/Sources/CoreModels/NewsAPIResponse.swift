import Foundation

public struct NewsAPIResponse: Codable, Sendable, Equatable {
    public let status: String
    public let totalResults: Int?
    public let articles: [Article]?

    public init(status: String, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

public struct Article: Codable, Identifiable, Sendable, Equatable {
    public var id: String { url ?? UUID().uuidString }
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

    public init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

public struct Source: Codable, Sendable, Equatable {
    public let id: String?
    public let name: String?

    public init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

extension NewsAPIResponse {
    public static var mock: NewsAPIResponse {
        return NewsAPIResponse(
            status: "ok",
            totalResults: 2,
            articles: [
                Article.mock,
                Article(
                    source: Source(id: "the-verge", name: "The Verge"),
                    author: "Jane Doe",
                    title: "Another Breaking News",
                    description: "This is another example news description.",
                    url: "https://www.theverge.com/example-article",
                    urlToImage: "https://www.theverge.com/example-image.jpg",
                    publishedAt: "2025-08-13T10:00:00Z",
                    content: "This is another example news content."
                )
            ]
        )
    }

    public static var mockJSONString: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        if let data = try? encoder.encode(mock),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        return "{}"
    }
}

extension Article {
    public static var mock: Article {
        return Article(
            source: Source(id: "bbc-news", name: "BBC News"),
            author: "John Doe",
            title: "Breaking News Title",
            description: "This is a sample news description.",
            url: "https://www.bbc.com/news/example-article",
            urlToImage: "https://www.bbc.com/news/example-image.jpg",
            publishedAt: "2025-08-13T09:00:00Z",
            content: "This is a sample news content."
        )
    }
}

extension Source {
    public static var mock: Source {
        return Source(id: "bbc-news", name: "BBC News")
    }
}
