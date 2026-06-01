import SwiftUI

struct EmptyStateView: View {

    let title: String
    let message: String
    let systemImage: String

    var body: some View {

        VStack(spacing: 18) {

            Image(systemName: systemImage)
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text(title)
                .font(.title2.bold())

            Text(message)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
