import SwiftUI
import RealityKit

struct SafetyDeskPreviewView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            areaHeader(
                title: "Safety Desk",
                subtitle: "A spatial area for safeguarding, emergency contacts, and compliance information.",
                image: "shield.lefthalf.filled",
                color: .red
            )

            RealityView { content in
                let safetyDesk = NurseryEntity.createSafetyDesk()
                safetyDesk.position = [0, -0.2, 0]
                content.add(safetyDesk)
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
