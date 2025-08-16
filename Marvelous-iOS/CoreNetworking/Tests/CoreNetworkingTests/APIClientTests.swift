import XCTest
@testable import CoreNetworking

final class APIClientTests: XCTestCase {
    
    /// Tests for `APIClient`.
    ///
    /// No `setUp` or `tearDown` methods are used here because each test builds
    /// its own `APIClient` (SUT) and `URLSessionMock` with specific data/response/error.
    /// Keeping the setup inline makes each scenario explicit and avoids hidden state.

    func testFetchDeliversDecodedObjectOn200HTTPResponseWithValidJSON() async throws {
        let data = try JSONSerialization.data(withJSONObject: ["test": "value"])
        let (sut, session) = makeSUT(data: data, response: httpURLResponse(statusCode: 200))

        let request = anyRequest()

        let result = try await sut.fetch([String: String].self, from: request)

        XCTAssertEqual(result, ["test": "value"])
        XCTAssertEqual(session.requests.count, 1)
        XCTAssertEqual(session.requests.first, request)
    }

    func testFetchThrowsInvalidURLOnNonHTTPResponse() async {
        let (sut, _) = makeSUT(data: anyData(), response: nonHTTPURLResponse())

        let request = anyRequest()

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                break // expected
            default:
                XCTFail("Expected .invalidURL error, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsRequestFailedOnNon200HTTPResponse() async {
        let (sut, _) = makeSUT(data: anyData(), response: httpURLResponse(statusCode: 500))

        let request = anyRequest()

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            switch error {
            case .requestFailed(let statusCode):
                XCTAssertEqual(statusCode, 500)
            default:
                XCTFail("Expected .requestFailed error, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsDecodingErrorOn200HTTPResponseWithInvalidJSON() async {
        let invalidJSON = Data("invalid json".utf8)
        let (sut, _) = makeSUT(data: invalidJSON, response: httpURLResponse(statusCode: 200))

        let request = anyRequest()

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            if case .decodingError = error {
                // expected
            } else {
                XCTFail("Expected .decodingError, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }

    func testFetchThrowsUnderlyingErrorOnRequestError() async {
        let testError = NSError(domain: "test", code: 0)
        let requestError = NetworkError.unknown(testError)
        let (sut, session) = makeSUT(error: requestError)

        let request = anyRequest()

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            switch error {
            case .unknown(let underlyingError):
                XCTAssertEqual(underlyingError as NSError, testError)
            default:
                XCTFail("Expected .unknown error, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }

        XCTAssertEqual(session.requests.count, 1)
        XCTAssertEqual(session.requests.first, request)
    }

    func testFetchThrowsDecodingErrorOn200HTTPResponseWithEmptyData() async {
        let (sut, _) = makeSUT(data: Data(), response: httpURLResponse(statusCode: 200))

        let request = anyRequest()

        do {
            _ = try await sut.fetch([String: String].self, from: request)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            if case .decodingError = error {
                // expected
            } else {
                XCTFail("Expected .decodingError, got \(error)")
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

    private func anyURL() -> URL {
        // Safe to force-unwrap because the URL literal is valid
        return URL(string: "http://any-url.com")!
    }

    private func anyRequest() -> URLRequest {
        return URLRequest(url: anyURL())
    }

    private func anyData() -> Data {
        return Data("any data".utf8)
    }

    private func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }

    private func httpURLResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
