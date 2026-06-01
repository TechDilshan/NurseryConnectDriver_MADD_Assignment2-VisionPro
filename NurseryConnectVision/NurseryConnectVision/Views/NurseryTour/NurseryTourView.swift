import SwiftUI
import RealityKit

struct NurseryTourView: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 0) {
            headerSection
                .padding(.horizontal, 36)
                .padding(.top, 32)
                .padding(.bottom, 24)

            areaTabBar
                .padding(.horizontal, 36)
                .padding(.bottom, 24)

            HStack(alignment: .top, spacing: 20) {
                selectedAreaView
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 420)

                TourInfoPanel()
                    .frame(width: 340)
            }
            .padding(.horizontal, 36)

            Spacer()
        }
        .background(areaGradientBackground)
        .animation(.easeInOut(duration: 0.4), value: nurseryTourViewModel.selectedArea)
    }

    private var areaGradientBackground: some View {
        ZStack {
            LinearGradient(
                colors: [
                    nurseryTourViewModel.selectedArea.themeColor.opacity(0.18),
                    nurseryTourViewModel.selectedArea.themeColor.opacity(0.06),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            nurseryTourViewModel.selectedArea.themeColor.opacity(0.22),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 260
                    )
                )
                .frame(width: 520, height: 520)
                .offset(x: -200, y: -80)
                .blur(radius: 40)
        }
    }

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 10) {
                    Image(systemName: "building.2.fill")
                        .foregroundStyle(nurseryTourViewModel.selectedArea.themeColor)
                        .font(.title3)
                    Text("NurseryConnect")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                Text("Immersive\nNursery Tour")
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .lineSpacing(2)

                Text("Explore every space in stunning spatial 3D")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 2)
            }

            Spacer()

            VStack(spacing: 10) {
                Button {
                    Task { await startImmersiveSession() }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "play.circle.fill")
                            .font(.body.weight(.semibold))
                        Text("Start Immersive Mode")
                            .font(.body.weight(.semibold))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(immersiveViewModel.isImmersiveSpaceOpen)

                Button {
                    Task {
                        await dismissImmersiveSpace()
                        immersiveViewModel.markImmersiveSpaceClosed()
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "stop.circle.fill")
                        Text("Stop Immersive")
                    }
                    .font(.subheadline)
                }
                .buttonStyle(.bordered)
                .disabled(!immersiveViewModel.isImmersiveSpaceOpen)
            }
        }
    }

    private func startImmersiveSession() async {
        let area = nurseryTourViewModel.selectedArea
        immersiveViewModel.prepareImmersiveStart(area: area)
        immersiveViewModel.selectArea(area)
        switch await openImmersiveSpace(id: AppConstants.immersiveSpaceID) {
        case .opened:
            immersiveViewModel.markImmersiveSpaceOpened()
        case .userCancelled:
            immersiveViewModel.markImmersiveOpenCancelled()
        case .error:
            immersiveViewModel.markImmersiveOpenFailed()
        @unknown default:
            immersiveViewModel.markImmersiveOpenFailed()
        }
    }

    private var areaTabBar: some View {
        HStack(spacing: 10) {
            ForEach(NurseryArea.allCases) { area in
                AreaTabButton(
                    area: area,
                    isSelected: nurseryTourViewModel.selectedArea == area
                ) {
                    nurseryTourViewModel.selectArea(area)
                    immersiveViewModel.selectArea(area)
                }
            }
        }
    }

    @ViewBuilder
    private var selectedAreaView: some View {
        switch nurseryTourViewModel.selectedArea {
        case .classroom:     ClassroomView()
        case .playArea:      PlayAreaView()
        case .diningArea:    DiningAreaView()
        case .outdoorGarden: OutdoorAreaView()
        case .readingCorner: ReadingCornerView()
        case .safetyDesk:    SafetyDeskPreviewView()
        }
    }
}

struct AreaTabButton: View {
    let area: NurseryArea
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(isSelected ? area.themeColor : Color.clear)
                        .frame(width: 46, height: 46)
                    Circle()
                        .strokeBorder(
                            isSelected ? area.themeColor : Color.secondary.opacity(0.3),
                            lineWidth: 1.5
                        )
                        .frame(width: 46, height: 46)
                    Image(systemName: area.systemImage)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : .secondary)
                }
                Text(area.title)
                    .font(.caption.weight(isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? area.themeColor : .secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? area.themeColor.opacity(0.12) : Color.clear)
            )
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
