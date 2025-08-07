import SwiftUI

@main
struct MarvelousiOSApp: App {
    let secrets: SecretsProvider? = try? Secrets()

    var body: some Scene {
        WindowGroup {
            Text(secrets?.marvelPublicKey ?? "Missing Public Key")
                .font(.largeTitle)
                .padding()
            Text(secrets?.marvelPrivateKey ?? "Missing Private Key")
                .font(.largeTitle)
                .padding()
        }
    }
}
