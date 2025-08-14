import XCTest
@testable import CoreNetworking

final class APIClientTests: XCTestCase {

    func testFetchDeliversDecodedObjectOn200HTTPResponseWithValidJSON() async throws {
        let data = try JSONSerialization.data(withJSONObject: ["test": "value"])
        let (sut, session) = makeSUT(data: data, response: httpURLResponse(statusCode: 200))

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        let result = try await sut.fetch([String: String].self, from: request)

        XCTAssertEqual(result, ["test": "value"])
        XCTAssertEqual(session.requests.count, 1)
        XCTAssertEqual(session.requests.first, request)
    }

    func testFetchThrowsInvalidURLOnNonHTTPResponse() async {
        let (sut, _) = makeSUT(data: anyData(), response: nonHTTPURLResponse())

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .invalidURL = error else {
                XCTFail("Expected .invalidURL error, got \(error)")
                return
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsRequestFailedOnNon200HTTPResponse() async {
        let (sut, _) = makeSUT(data: anyData(), response: httpURLResponse(statusCode: 500))

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .requestFailed(let statusCode) = error else {
                XCTFail("Expected .requestFailed error, got \(error)")
                return
            }
            XCTAssertEqual(statusCode, 500)
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsDecodingErrorOn200HTTPResponseWithInvalidJSON() async {
        let invalidJSON = Data("invalid json".utf8)
        let (sut, _) = makeSUT(data: invalidJSON, response: httpURLResponse(statusCode: 200))

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .decodingError = error else {
                XCTFail("Expected .decodingError, got \(error)")
                return
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsUnderlyingErrorOnRequestError() async {
        let testError = NSError(domain: "test", code: 0)
        let requestError = NetworkError.unknown(testError)
        let (sut, session) = makeSUT(error: requestError)

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .unknown(let underlyingError) = error else {
                XCTFail("Expected .unknown error, got \(error)")
                return
            }
            XCTAssertEqual(underlyingError as NSError, testError)
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }

        XCTAssertEqual(session.requests.count, 1)
        XCTAssertEqual(session.requests.first, request)
    }

    func testFetchThrowsDecodingErrorOn200HTTPResponseWithEmptyData() async {
        let (sut, _) = makeSUT(data: Data(), response: httpURLResponse(statusCode: 200))

        guard let request = anyRequest() else {
            XCTFail("Failed to create request")
            return
        }

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .decodingError = error else {
                XCTFail("Expected .decodingError, got \(error)")
                return
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    private func makeSUT(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil, file: StaticString = #filePath, line: UInt = #line) -> (sut: APIClient, session: URLSessionMock) {
        let session = URLSessionMock()
        session.mockData = data
        session.mockResponse = response
        session.mockError = error

        let sut = APIClient(session: session)

        return (sut, session)
    }

    private func anyURL() -> URL? {
        return URL(string: "http://any-url.com")
    }

    private func anyRequest() -> URLRequest? {
        guard let url = anyURL() else { return nil }
        return URLRequest(url: url)
    }

    private func anyData() -> Data {
        return Data("any data".utf8)
    }

    private func nonHTTPURLResponse() -> URLResponse? {
        guard let url = anyURL() else { return nil }
        return URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }

    private func httpURLResponse(statusCode: Int) -> HTTPURLResponse? {
        guard let url = anyURL() else { return nil }
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
