import Foundation

public struct Hero: Decodable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let resourceURI: String
    public let comics: ComicList
    public let series: SeriesList
    public let stories: StoryList
    public let events: EventList
}

public struct ComicList: Decodable, Sendable {
    public let available: Int
    public let items: [ComicSummary]
}

public struct ComicSummary: Decodable, Sendable {
    public let resourceURI: String
    public let name: String
}

public struct SeriesList: Decodable, Sendable {
    public let available: Int
    public let items: [SeriesSummary]
}

public struct SeriesSummary: Decodable, Sendable {
    public let resourceURI: String
    public let name: String
}

public struct StoryList: Decodable, Sendable {
    public let available: Int
    public let items: [StorySummary]
}

public struct StorySummary: Decodable, Sendable {
    public let resourceURI: String
    public let name: String
    public let type: String?
}

public struct EventList: Decodable, Sendable {
    public let available: Int
    public let items: [EventSummary]
}

public struct EventSummary: Decodable, Sendable {
    public let resourceURI: String
    public let name: String
}
