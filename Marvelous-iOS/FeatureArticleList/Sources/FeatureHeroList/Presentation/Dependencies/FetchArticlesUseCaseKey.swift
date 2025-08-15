import ComposableArchitecture
import CoreModels
import CoreNetworking
import Config

struct FetchArticlesUseCaseKey: DependencyKey {
    static let liveValue: FetchArticlesUseCase = {
        var apiKey = "TEXT_API_KEY"
        if let secrets = try? Secrets() {
            apiKey = secrets.newsAPIKey
        }

        let apiClient = APIClient()
        let newsAPI = NewsAPI(apiKey: apiKey, client: apiClient)
        let repository = NewsArticlesRepository(api: newsAPI)
        return FetchArticlesUseCase(repo: repository)
    }()
}

extension DependencyValues {
    var fetchArticlesUseCase: FetchArticlesUseCase {
        get { self[FetchArticlesUseCaseKey.self] }
        set { self[FetchArticlesUseCaseKey.self] = newValue }
    }
}
