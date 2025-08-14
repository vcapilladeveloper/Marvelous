import SwiftUI
import DesignSystem
import FeatureArticleList
import ComposableArchitecture

@main
struct MarvelousiOSApp: App {
    @State private var errorMessage: String?
    private let store: StoreOf<ArticleListFeature>?

    init() {
        self.store = Store(initialState: .init(), reducer: { ArticleListFeature() })
    }

    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    if let errorMessage {
                        ErrorView(message: errorMessage, onRetry: {})
                            .padding()
                    } else if let store {
                        ArticleListView(store: store)
                    } else {
                        LoadingView()
                    }
                }
                if showSplash {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text("TechNews")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(DSPalette.brand)
                            .opacity(showSplash ? 1 : 0)
                            .transition(.opacity)
                        Spacer()
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
