import Foundation

/// I'm using enum in order to group the keys together.
/// I decided to use an enum instead of a struct to avoid possible instances
enum SecretsKeys {
    static let newsAPIKey = "NewsAPiKey"
}

public struct Secrets: SecretsProvider {
    public let newsAPIKey: String

    public init(infoDictionary: [String: Any] = Bundle.main.infoDictionary ?? [:]) throws {
        func load(_ key: String) throws -> String {
            guard
                let raw = infoDictionary[key] as? String,
                !raw.isEmpty
            else {
                throw SecretsError.missingKey(key)
            }
            return raw.replacingOccurrences(of: "\\", with: "")
        }

        self.newsAPIKey = try load(SecretsKeys.newsAPIKey)
    }
}
