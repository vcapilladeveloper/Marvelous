import Foundation
import CryptoKit

public extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
