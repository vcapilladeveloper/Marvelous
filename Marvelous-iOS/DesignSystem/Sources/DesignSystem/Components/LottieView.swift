import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop

    public func makeUIView(context: Context) -> UIView {
        let container = UIView()
        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: container.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode

        if let anim = LottieAnimation.named(name, bundle: .module) {
            animationView.animation = anim
            animationView.play()
            return container
        }

        if let url = Bundle.module.url(forResource: name, withExtension: "json"),
           let anim = LottieAnimation.filepath(url.path) {
            animationView.animation = anim
            animationView.play()
            return container
        }

        #if DEBUG
        print("❌ Lottie asset not found: name='\(name)')'")
        #endif
        return container
    }

    public func updateUIView(_ uiView: UIView, context: Context) { }
}
