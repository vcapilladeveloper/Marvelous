import ComposableArchitecture
import CoreModels
import CoreNetworking
import Config

struct FetchArticlesUseCaseKey: DependencyKey {
    static let liveValue: FetchArticlesUseCase = {
        do {
            let secrets = try Secrets()
            let apiClient = APIClient()
            let newsAPI = NewsAPI(apiKey: secrets.newsAPIKey, client: apiClient)
            let repository = NewsArticlesRepository(api: newsAPI)
            return FetchArticlesUseCase(repo: repository)
        } catch {
            fatalError("Failed to load secrets: \(error)")
        }
    }()
}

extension DependencyValues {
    var fetchArticlesUseCase: FetchArticlesUseCase {
        get { self[FetchArticlesUseCaseKey.self] }
        set { self[FetchArticlesUseCaseKey.self] = newValue }
    }
}
