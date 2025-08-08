import SwiftUI
import Config

@main
struct MarvelousiOSApp: App {
    @State private var errorMessage: String?
    let secrets: SecretsProvider?

    init() {
        do {
            secrets = try Secrets()
        } catch {
            secrets = nil
            errorMessage =
                "Failed to load secrets: You can't provided the secrets in the Info.plist file. Please ensure that you have added the required keys."
        }
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Text(secrets?.marvelPublicKey ?? "Missing Public Key")
                        .font(.largeTitle)
                        .padding()
                    Text(secrets?.marvelPrivateKey ?? "Missing Private Key")
                        .font(.largeTitle)
                        .padding()
                }
            }

        }
    }
}
