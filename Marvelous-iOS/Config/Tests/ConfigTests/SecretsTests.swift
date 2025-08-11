import XCTest
@testable import Config

final class SecretsTests: XCTestCase {
    func testSecretsLoadsValues() {
        let fakeInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: "testPublic"
        ]

        do {
            let secrets = try Secrets(infoDictionary: fakeInfo)
            XCTAssertEqual(secrets.newsAPIKey, "testPublic")
        } catch {
            XCTFail("Failed to load secrets: \(error)")
        }
    }

    func testSecretsFatalError() {
        let fakeInfo: [String: Any] = ["fatalErrorTest": "errorTest"]
        XCTAssertThrowsError(try Secrets(infoDictionary: fakeInfo))
    }
}
