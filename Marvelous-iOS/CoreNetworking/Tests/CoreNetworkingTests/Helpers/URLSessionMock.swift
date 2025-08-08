import Foundation
@testable import CoreNetworking

struct URLSessionMock: URLSessionProtocol {
    let mockData: Data
    let mockResponse: URLResponse
    let mockError: Error?

    init(data: Data, response: URLResponse, error: Error?) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError { throw error }
        return (mockData, mockResponse)
    }
}
