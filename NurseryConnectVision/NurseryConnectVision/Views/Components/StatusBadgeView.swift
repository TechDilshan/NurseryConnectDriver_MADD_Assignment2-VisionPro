import SwiftUI

struct StatusBadgeView: View {

    let title: String
    let color: Color

    var body: some View {

        Text(title)
            .font(.caption.bold())
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundStyle(color)
            .background(
                color.opacity(0.15)
            )
            .clipShape(Capsule())
    }
}
