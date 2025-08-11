import Foundation

extension Date {
    static func iso8601(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let data = formatter.date(from: string) { return data }
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: string)
    }
}
