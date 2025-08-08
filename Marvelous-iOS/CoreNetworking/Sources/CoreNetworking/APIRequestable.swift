import Foundation
import CoreModels

public protocol APIRequestable {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}

public final class APIClient: APIRequestable {
    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidURL
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
