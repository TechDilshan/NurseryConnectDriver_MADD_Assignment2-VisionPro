import SwiftUI
import RealityKit

// MARK: - Shared Area Detail Card

struct AreaDetailCard<Scene: View>: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let gradient: [Color]
    let scene: () -> Scene

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 88)

                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.2))
                            .frame(width: 50, height: 50)
                        Image(systemName: icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(title)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.85))
                            .lineLimit(2)
                    }
                    Spacer()

                    Text("3D")
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.25))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }

            ZStack {
                LinearGradient(
                    colors: [Color.black.opacity(0.85), Color(.sRGB, red: 0.05, green: 0.05, blue: 0.15, opacity: 1)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                GridFloorOverlay(color: color)

                scene()
            }
            .frame(height: 300)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(color.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: color.opacity(0.2), radius: 20, x: 0, y: 8)
    }
}

// MARK: - Grid Floor Overlay

struct GridFloorOverlay: View {
    let color: Color

    var body: some View {
        Canvas { context, size in
            let spacing: CGFloat = 36
            let fadeStart = size.height * 0.4
            let cols = Int(size.width / spacing) + 2
            let rows = Int(size.height / spacing) + 2

            for col in 0...cols {
                let x = CGFloat(col) * spacing
                var path = Path()
                path.move(to: CGPoint(x: x, y: fadeStart))
                path.addLine(to: CGPoint(x: x, y: size.height))
                let fade = max(0, min(1, (size.height - fadeStart) / size.height))
                context.stroke(path, with: .color(color.opacity(0.12 * fade)), lineWidth: 0.5)
            }

            for row in 0...rows {
                let y = CGFloat(row) * spacing + fadeStart
                guard y > fadeStart else { continue }
                let fadeFactor = (y - fadeStart) / (size.height - fadeStart)
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(color.opacity(0.12 * fadeFactor)), lineWidth: 0.5)
            }
        }
    }
}
