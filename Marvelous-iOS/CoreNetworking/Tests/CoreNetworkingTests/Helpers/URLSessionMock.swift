import Foundation
@testable import CoreNetworking

// Note: This mock is intentionally not Sendable for testing purposes
final class URLSessionMock: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var requests: [URLRequest] = []

    init() {}

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        requests.append(request)
        if let error = mockError { throw error }

        guard let data = mockData, let response = mockResponse else {
            throw NetworkError.unknown(NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock data or response not set"]))
        }

        return (data, response)
    }
}

// Extension to make it Sendable for the protocol requirement
extension URLSessionMock: @unchecked Sendable {}
