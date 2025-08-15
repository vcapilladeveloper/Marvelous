import ComposableArchitecture
import CoreModels
import CoreNetworking
import Config

struct FetchArticlesUseCaseKey: DependencyKey {
    static var liveValue: FetchArticlesUseCase {
        let apiKey: String = (try? Secrets())?.newsAPIKey ?? "TEXT_API_KEY"
        let apiClient = APIClient()
        let newsAPI = NewsAPI(apiKey: apiKey, client: apiClient)
        let remote = RemoteArticlesDataSource(api: newsAPI)
        let repository = NewsArticlesRepository(remote: remote)
        return FetchArticlesUseCase(repo: repository)
    }
}

extension DependencyValues {
    var fetchArticlesUseCase: FetchArticlesUseCase {
        get { self[FetchArticlesUseCaseKey.self] }
        set { self[FetchArticlesUseCaseKey.self] = newValue }
    }
}
