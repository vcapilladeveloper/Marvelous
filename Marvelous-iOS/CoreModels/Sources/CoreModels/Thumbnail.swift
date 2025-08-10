import Foundation

public struct Thumbnail: Decodable, Sendable, Equatable {
    public let path: String
    public let `extension`: String

    public var url: URL? {
        URL(string: "\(path).\(self.extension)".replacingOccurrences(of: "http://", with: "https://"))
    }
}
