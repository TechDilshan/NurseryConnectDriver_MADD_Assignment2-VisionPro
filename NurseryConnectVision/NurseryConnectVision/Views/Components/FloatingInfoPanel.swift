import SwiftUI

struct FloatingInfoPanel: View {

    let title: String
    let description: String
    let systemImage: String

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(.blue)

                Text(title)
                    .font(.headline)
            }

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 22)
        )
    }
}
