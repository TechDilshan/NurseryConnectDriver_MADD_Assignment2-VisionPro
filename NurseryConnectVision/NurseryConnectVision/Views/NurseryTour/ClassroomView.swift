import SwiftUI
import RealityKit

struct ClassroomView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            areaHeader(
                title: "Classroom",
                subtitle: "A calm learning space for early literacy, numeracy, and guided activities.",
                image: "studentdesk",
                color: .blue
            )

            RealityView { content in
                let classroom = ClassroomEntity.create()
                classroom.position = [0, -0.2, 0]
                content.add(classroom)
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
