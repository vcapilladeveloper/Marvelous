import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .decodingError(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
