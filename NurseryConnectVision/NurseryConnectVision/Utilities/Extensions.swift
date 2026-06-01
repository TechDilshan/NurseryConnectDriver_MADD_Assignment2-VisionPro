import SwiftUI

extension View {

    func glassCardStyle() -> some View {
        self
            .padding()
            .background(.regularMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
            )
    }

    func sectionCardStyle() -> some View {
        self
            .padding()
            .background(
                ColorTheme.cardBackground
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
            )
    }
}

extension Color {

    static let nurseryBlue =
        Color.blue

    static let nurseryGreen =
        Color.green

    static let nurseryOrange =
        Color.orange

    static let nurseryPurple =
        Color.purple

    static let nurseryRed =
        Color.red
}
