import Foundation

public struct APIResponse<T: Decodable>: Decodable {
    public let code: Int
    public let status: String
    public let data: APIDataContainer<T>
}

public struct APIDataContainer<T: Decodable>: Decodable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [T]
}
