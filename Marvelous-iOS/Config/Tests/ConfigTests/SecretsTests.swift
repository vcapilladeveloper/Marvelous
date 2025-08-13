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

    func testSecretsWithEmptyDictionary() {
        let emptyInfo: [String: Any] = [:]
        XCTAssertThrowsError(try Secrets(infoDictionary: emptyInfo))
    }

    func testSecretsWithNilValues() {
        let nilInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: NSNull()
        ]
        XCTAssertThrowsError(try Secrets(infoDictionary: nilInfo))
    }

    func testSecretsWithWrongType() {
        let wrongTypeInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: 123
        ]
        XCTAssertThrowsError(try Secrets(infoDictionary: wrongTypeInfo))
    }

    func testSecretsWithEmptyString() {
        let emptyStringInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: ""
        ]
        XCTAssertThrowsError(try Secrets(infoDictionary: emptyStringInfo))
    }

    func testSecretsWithValidAPIKey() {
        let validInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: "valid_api_key_123"
        ]

        do {
            let secrets = try Secrets(infoDictionary: validInfo)
            XCTAssertEqual(secrets.newsAPIKey, "valid_api_key_123")
            XCTAssertFalse(secrets.newsAPIKey.isEmpty)
        } catch {
            XCTFail("Failed to load secrets with valid API key: \(error)")
        }
    }

    func testSecretsWithSpecialCharacters() {
        let specialCharInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: "api_key_with_special_chars_!@#$%^&*()"
        ]

        do {
            let secrets = try Secrets(infoDictionary: specialCharInfo)
            XCTAssertEqual(secrets.newsAPIKey, "api_key_with_special_chars_!@#$%^&*()")
        } catch {
            XCTFail("Failed to load secrets with special characters: \(error)")
        }
    }

    func testSecretsWithLongAPIKey() {
        let longKey = String(repeating: "a", count: 1000)
        let longKeyInfo: [String: Any] = [
            SecretsKeys.newsAPIKey: longKey
        ]

        do {
            let secrets = try Secrets(infoDictionary: longKeyInfo)
            XCTAssertEqual(secrets.newsAPIKey, longKey)
            XCTAssertEqual(secrets.newsAPIKey.count, 1000)
        } catch {
            XCTFail("Failed to load secrets with long API key: \(error)")
        }
    }
}
