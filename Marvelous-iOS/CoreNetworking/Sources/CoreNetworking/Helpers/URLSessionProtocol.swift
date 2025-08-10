import Foundation

public protocol URLSessionProtocol: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
extension URLSession: URLSessionProtocol {}
