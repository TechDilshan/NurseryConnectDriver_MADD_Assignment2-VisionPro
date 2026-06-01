import SwiftUI

enum ColorTheme {

    static let primaryBlue =
        Color.blue

    static let secondaryPurple =
        Color.purple

    static let successGreen =
        Color.green

    static let warningOrange =
        Color.orange

    static let dangerRed =
        Color.red

    static let cardBackground =
        Color.white.opacity(0.08)

    static let glassBackground =
        Color.white.opacity(0.12)

    static let dashboardGradient =
        LinearGradient(
            colors: [
                Color.blue.opacity(0.15),
                Color.purple.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    static let transportGradient =
        LinearGradient(
            colors: [
                Color.orange.opacity(0.15),
                Color.blue.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    static let safetyGradient =
        LinearGradient(
            colors: [
                Color.red.opacity(0.12),
                Color.blue.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    static let tourGradient =
        LinearGradient(
            colors: [
                Color.green.opacity(0.12),
                Color.blue.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
}
