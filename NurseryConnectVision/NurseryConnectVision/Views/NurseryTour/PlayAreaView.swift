import SwiftUI
import RealityKit

struct PlayAreaView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            areaHeader(
                title: "Play Area",
                subtitle: "A supervised space designed for social play and physical development.",
                image: "figure.play",
                color: .orange
            )

            RealityView { content in
                let playground = PlaygroundEntity.create()
                playground.position = [0, -0.2, 0]
                content.add(playground)
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
