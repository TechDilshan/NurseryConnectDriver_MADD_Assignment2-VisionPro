import SwiftUI

struct TourInfoPanel: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Panel header
            panelHeader

            Divider().padding(.horizontal, 20)

            // Description
            descriptionSection

            Divider().padding(.horizontal, 20)

            // Highlights grid
            highlightsSection

            Spacer()

            // Bottom action
            actionButton
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(nurseryTourViewModel.selectedArea.themeColor.opacity(0.25), lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.35), value: nurseryTourViewModel.selectedArea)
    }

    // MARK: - Header

    private var panelHeader: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(nurseryTourViewModel.selectedArea.themeColor.opacity(0.2))
                    .frame(width: 48, height: 48)
                Image(systemName: nurseryTourViewModel.selectedArea.systemImage)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(nurseryTourViewModel.selectedArea.themeColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(nurseryTourViewModel.selectedArea.title)
                    .font(.title3.bold())
                Text("Area Details")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(20)
    }

    // MARK: - Description

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("About this space", systemImage: "info.circle.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(nurseryTourViewModel.selectedArea.themeColor)

            Text(nurseryTourViewModel.selectedArea.description)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(3)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }

    // MARK: - Highlights

    private var highlightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Key Features", systemImage: "checkmark.seal.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(nurseryTourViewModel.selectedArea.themeColor)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(nurseryTourViewModel.selectedArea.highlights, id: \.self) { highlight in
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(nurseryTourViewModel.selectedArea.themeColor)
                        Text(highlight)
                            .font(.caption)
                            .lineLimit(2)
                        Spacer(minLength: 0)
                    }
                    .padding(8)
                    .background(nurseryTourViewModel.selectedArea.themeColor.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }

    // MARK: - Action button

    private var actionButton: some View {
        VStack(spacing: 10) {
            Button {
                Task { await startImmersiveSession() }
            } label: {
                HStack {
                    Image(systemName: "play.circle.fill")
                    Text("Start Immersive Mode")
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .disabled(immersiveViewModel.isImmersiveSpaceOpen)

            if immersiveViewModel.isImmersiveSpaceOpen {
                Button {
                    Task {
                        await dismissImmersiveSpace()
                        immersiveViewModel.markImmersiveSpaceClosed()
                    }
                } label: {
                    HStack {
                        Image(systemName: "stop.circle.fill")
                        Text("Stop Immersive")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(20)
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
}
