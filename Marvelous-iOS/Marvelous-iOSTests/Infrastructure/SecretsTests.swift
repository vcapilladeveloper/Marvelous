import XCTest
@testable import Marvelous_iOS

final class SecretsTests: XCTestCase {
    func testSecretsLoadsValues() {
        let fakeInfo: [String: Any] = [
            "MarvelPublicKey": "testPublic",
            "MarvelPrivateKey": "testPrivate"
        ]

        do {
            let secrets = try Secrets(infoDictionary: fakeInfo)
            XCTAssertEqual(secrets.marvelPublicKey, "testPublic")
            XCTAssertEqual(secrets.marvelPrivateKey, "testPrivate")
        } catch {
            XCTFail("Failed to load secrets: \(error)")
        }
    }

    func testSecretsFatalError() {
        let fakeInfo: [String: Any] = ["fatalErrorTest": "errorTest"]
        XCTAssertThrowsError(try Secrets(infoDictionary: fakeInfo))
    }
}
