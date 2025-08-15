import SwiftUI
import DesignSystem
import FeatureArticleList
import ComposableArchitecture

@main
struct MarvelousiOSApp: App {
    private let store: StoreOf<ArticleListFeature>?

    init() {
        self.store = Store(initialState: .init(), reducer: { ArticleListFeature() })
    }

    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    if let store {
                        ArticleListView(store: store)
                    } else {
                        LoadingView()
                    }
                }
                if showSplash {
                    Group {
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
                    .accessibilityIdentifier("SplashScreen")
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
