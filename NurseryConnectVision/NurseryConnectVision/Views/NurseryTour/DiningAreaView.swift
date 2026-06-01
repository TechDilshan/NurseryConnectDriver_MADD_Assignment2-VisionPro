import SwiftUI
import RealityKit

struct DiningAreaView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            areaHeader(
                title: "Dining Area",
                subtitle: "An allergen-aware meal area for safe and supervised food routines.",
                image: "fork.knife",
                color: .green
            )

            RealityView { content in
                let dining = DiningEntity.create()
                dining.position = [0, -0.2, 0]
                content.add(dining)
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
