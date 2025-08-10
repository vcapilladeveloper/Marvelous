import Foundation
import CoreModels

public protocol APIRequestable: Sendable {
    func fetch<T: Decodable & Sendable>(_ type: T.Type, from url: URLRequest) async throws -> T
}

public final class APIClient: APIRequestable, @unchecked Sendable {
    private let session: URLSessionProtocol
    public init(session: URLSessionProtocol = URLSession.shared) { self.session = session }

    public func fetch<T: Decodable & Sendable>(_ type: T.Type, from request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidURL }
        guard 200..<300 ~= http.statusCode else { throw NetworkError.requestFailed(statusCode: http.statusCode) }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
