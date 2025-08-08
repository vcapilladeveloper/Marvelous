import Foundation

public enum SecretsError: LocalizedError {
  case missingKey(String)

  public var errorDescription: String? {
    switch self {
    case .missingKey(let key):
      return "🔑 Missing required Info.plist key: \(key)"
    }
  }
}
