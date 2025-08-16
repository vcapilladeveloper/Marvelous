import SwiftUI
import DesignSystem

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("TechNews")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(DSPalette.brand)
                Spacer()
            }
        }
        .accessibilityIdentifier("SplashScreen")
    }
}
