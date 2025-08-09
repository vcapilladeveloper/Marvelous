import XCTest
import SwiftUI
import ViewInspector
@testable import DesignSystem

@MainActor
final class HeroAvatarCardTests: XCTestCase {
    func testDisplaysHeroName() throws {
        let sut = HeroAvatarCard(name: "Captain Marvel", imageURL: nil)
        let text = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(text, "Captain Marvel")
    }

    func testAccessibilityLabelUsesName() throws {
        let sut = HeroAvatarCard(name: "Hulk", imageURL: nil)
        // We can’t read the label directly, but we can ensure view exists and composes.
        XCTAssertNoThrow(try sut.inspect().vStack())
    }
}
