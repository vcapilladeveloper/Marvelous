import Foundation

public struct Hero: Decodable, Identifiable {
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

public struct ComicList: Decodable {
    public let available: Int
    public let items: [ComicSummary]
}

public struct ComicSummary: Decodable {
    public let resourceURI: String
    public let name: String
}

public struct SeriesList: Decodable {
    public let available: Int
    public let items: [SeriesSummary]
}

public struct SeriesSummary: Decodable {
    public let resourceURI: String
    public let name: String
}

public struct StoryList: Decodable {
    public let available: Int
    public let items: [StorySummary]
}

public struct StorySummary: Decodable {
    public let resourceURI: String
    public let name: String
    public let type: String?
}

public struct EventList: Decodable {
    public let available: Int
    public let items: [EventSummary]
}

public struct EventSummary: Decodable {
    public let resourceURI: String
    public let name: String
}
