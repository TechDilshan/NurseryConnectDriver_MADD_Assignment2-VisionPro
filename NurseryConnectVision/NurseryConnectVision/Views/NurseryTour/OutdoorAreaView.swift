import SwiftUI
import RealityKit

struct OutdoorAreaView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            areaHeader(
                title: "Outdoor Garden",
                subtitle: "A safe outdoor area for movement, exploration, and nature-based learning.",
                image: "leaf.fill",
                color: .green
            )

            RealityView { content in
                let garden = GardenEntity.create()
                garden.position = [0, -0.2, 0]
                content.add(garden)
            }
            .frame(height: 280)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func areaHeader(title: String, subtitle: String, image: String, color: Color) -> some View {
        HStack(spacing: 16) {
            Image(systemName: image)
                .font(.title)
                .foregroundStyle(color)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2.bold())

                Text(subtitle)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}
