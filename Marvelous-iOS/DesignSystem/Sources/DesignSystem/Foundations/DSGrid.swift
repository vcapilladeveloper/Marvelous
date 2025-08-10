import SwiftUI

public enum DSGrid {
    /// 3 columns for the heroes grid
    public static var threeColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: DSSpacing.medium, alignment: .top), count: 3)
    }
}
