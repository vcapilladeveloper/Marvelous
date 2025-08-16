import SwiftUI
import DesignSystem
import CoreModels
import FeatureArticleList
import FeatureArticleDetails
import ComposableArchitecture

@main
struct MarvelousiOSApp: App {
    @State private var showSplash = true
    @State private var selectedArticle: Article?

    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    SplashView()
                } else {
                    NavigationStack {
                        ArticleListCoordinator { article in
                            selectedArticle = article
                        }
                        .sheet(item: $selectedArticle) { article in
                            ArticleDetailCoordinator(article: article)
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.8)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}
