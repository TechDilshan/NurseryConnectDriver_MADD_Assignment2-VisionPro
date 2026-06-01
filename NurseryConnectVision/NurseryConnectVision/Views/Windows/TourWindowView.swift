import SwiftUI

struct TourWindowView: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            header

            immersiveControlCard

            HStack(spacing: 20) {
                tourMetricCard(
                    title: "Selected Area",
                    value: nurseryTourViewModel.selectedAreaTitle,
                    subtitle: "Preview + immersive focus",
                    icon: nurseryTourViewModel.selectedArea.systemImage,
                    color: nurseryTourViewModel.selectedArea.themeColor
                )

                tourMetricCard(
                    title: "Immersive",
                    value: immersiveViewModel.isImmersiveSpaceOpen ? "Running" : "Stopped",
                    subtitle: "Full spatial experience",
                    icon: "visionpro",
                    color: immersiveViewModel.isImmersiveSpaceOpen ? .green : .orange
                )
            }

            nurseryAreasPanel

            NurseryTourView()
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            LinearGradient(
                colors: [
                    Color.green.opacity(0.12),
                    Color.blue.opacity(0.08),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tour Window")
                .font(.largeTitle.bold())
            Text("Preview each nursery space, then start immersive mode for the full 3D walkthrough.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var immersiveControlCard: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeaderView(
                    title: "Immersive Mode",
                    subtitle: "Stay in spatial view until you tap Stop on the top task bar"
                )

                HStack(spacing: 14) {
                    Button {
                        Task { await startImmersiveSession() }
                    } label: {
                        Label("Start Immersive Mode", systemImage: "play.circle.fill")
                            .frame(maxWidth: .infinity)
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
                        Label("Stop Immersive", systemImage: "stop.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(!immersiveViewModel.isImmersiveSpaceOpen)
                }

                Text(immersiveViewModel.statusMessage)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var nurseryAreasPanel: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 18) {
                SectionHeaderView(
                    title: "Nursery Areas",
                    subtitle: "Select a space for the window preview and immersive start"
                )

                HStack(spacing: 14) {
                    ForEach(NurseryArea.allCases) { area in
                        Button {
                            nurseryTourViewModel.selectArea(area)
                            immersiveViewModel.selectArea(area)
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: area.systemImage)
                                    .font(.title2)
                                Text(area.title)
                                    .font(.caption.bold())
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 110, height: 88)
                        }
                        .buttonStyle(.bordered)
                    }
                }

                Text(nurseryTourViewModel.selectedAreaDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func startImmersiveSession() async {
        let area = nurseryTourViewModel.selectedArea
        immersiveViewModel.prepareImmersiveStart(area: area)
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

    private func tourMetricCard(
        title: String,
        value: String,
        subtitle: String,
        icon: String,
        color: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(color)
            Text(value)
                .font(.title.bold())
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}
