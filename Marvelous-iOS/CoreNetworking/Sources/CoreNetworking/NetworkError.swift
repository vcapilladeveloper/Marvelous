import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return String(localized: "Invalid URL.")
        case .requestFailed(let statusCode):
            return String(localized: "Request failed with status code \(statusCode).")
        case .decodingError(let error):
            return String(localized: "Decoding failed: \(error.localizedDescription)")
        case .unknown(let error):
            return String(localized: "Unknown error: \(error.localizedDescription)")
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.requestFailed(let lhsCode), .requestFailed(let rhsCode)):
            return lhsCode == rhsCode
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

extension String {
    init(
        localized keyAndValue: String.LocalizationValue,
        table: String? = nil,
        locale: Locale = .current,
        comment: StaticString? = nil
    ) {
        self.init(localized: keyAndValue, table: table, bundle: .module, locale: locale, comment: comment)
    }
}
