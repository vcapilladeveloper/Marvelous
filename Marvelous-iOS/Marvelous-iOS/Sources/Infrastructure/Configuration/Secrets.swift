import Foundation

public struct Secrets: SecretsProvider {
    public let marvelPublicKey: String
    public let marvelPrivateKey: String
    
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
        
        self.marvelPublicKey  = try load("MarvelPublicKey")
        self.marvelPrivateKey = try load("MarvelPrivateKey")
    }
}

