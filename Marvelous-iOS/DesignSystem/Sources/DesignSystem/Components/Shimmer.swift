import SwiftUI

public struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0
    public func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient:
                        Gradient(colors: [
                            .white.opacity(0), .white.opacity(0.35),
                            .white.opacity(0)
                        ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blendMode(.plusLighter)
                .mask(content)
                .offset(x: phase)
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2).repeatForever(autoreverses: false)
                ) {
                    phase = 180
                }
            }
    }
}

public extension View {
    func shimmer() -> some View { modifier(Shimmer()) }
}
