import SwiftUI
import Config
import CoreNetworking
import CoreModels

@main
struct MarvelousiOSApp: App {
    @State private var errorMessage: String?
    @State private var heroes: [Hero] = []
    @State private var isLoading = false

    let secrets: SecretsProvider?

    init() {
        do {
            secrets = try Secrets()
        } catch {
            secrets = nil
            errorMessage =
                "Failed to load secrets: You must provide the secrets in the Info.plist file. Please ensure that you have added the required keys."
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if isLoading {
                    ProgressView("Loading Heroes...")
                } else {
                    List(heroes) { hero in
                        HStack {
                            AsyncImage(url: hero.thumbnail.url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: 50, height: 50)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(hero.name)
                                .font(.headline)
                        }
                    }
                    .navigationTitle("Marvel Heroes")
                    .task {
                        await loadHeroes()
                    }
                }
            }
        }
    }

    @MainActor
    private func loadHeroes() async {
        guard let publicKey = secrets?.marvelPublicKey,
              let privateKey = secrets?.marvelPrivateKey else {
            errorMessage = "Missing Marvel API Keys"
            return
        }

        let apiClient = APIClient()
        let marvelAPI = MarvelAPI(publicKey: publicKey, privateKey: privateKey, apiClient: apiClient)

        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await marvelAPI.getCharacters(limit: 20, offset: 0)
            heroes = response.data.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
