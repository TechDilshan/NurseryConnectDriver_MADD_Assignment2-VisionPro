import SwiftUI

/// Fixed top task bar for immersive mode (ornament — does not move or scale with the 3D scene).
struct ImmersiveTopNavigationBar: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Label("NurseryConnect Immersive", systemImage: "visionpro")
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)

                Text(immersiveViewModel.selectedArea.title)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Spacer(minLength: 8)

                areaPicker

                stopButton
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThickMaterial)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)
        }
    }

    private var areaPicker: some View {
        HStack(spacing: 6) {
            ForEach(NurseryArea.allCases) { area in
                Button {
                    immersiveViewModel.selectArea(area)
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: area.systemImage)
                            .font(.caption2)
                        Text(area.title)
                            .font(.caption2.weight(immersiveViewModel.selectedArea == area ? .bold : .medium))
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(
                        immersiveViewModel.selectedArea == area
                            ? area.themeColor
                            : Color.white.opacity(0.12)
                    )
                    .foregroundStyle(immersiveViewModel.selectedArea == area ? .white : .primary)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var stopButton: some View {
        Button {
            Task {
                await dismissImmersiveSpace()
                immersiveViewModel.markImmersiveSpaceClosed()
            }
        } label: {
            Text("Stop")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                .background(Color.red)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
