import Foundation

public struct APIResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public let code: Int
    public let status: String
    public let data: APIDataContainer<T>
}

public struct APIDataContainer<T: Decodable & Sendable>: Decodable, Sendable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [T]
}
