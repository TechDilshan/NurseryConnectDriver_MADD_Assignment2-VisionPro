import SwiftUI

struct NurseryTourView: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            headerSection
            areaButtons

            HStack(alignment: .top, spacing: 22) {
                selectedAreaView
                    .frame(maxWidth: .infinity, minHeight: 380)

                TourInfoPanel()
                    .frame(width: 360)
            }

            Spacer()
        }
        .padding(32)
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

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Immersive Nursery Tour")
                    .font(.largeTitle.bold())

                Text("Explore the nursery environment through a beautiful spatial 3D model.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 12) {
                Button {
                    Task {
                        await openImmersiveSpace(id: AppConstants.immersiveSpaceID)
                    }
                } label: {
                    Label("Open Immersive Space", systemImage: "visionpro")
                }
                .buttonStyle(.borderedProminent)

                Button {
                    Task {
                        await dismissImmersiveSpace()
                    }
                } label: {
                    Label("Close", systemImage: "xmark.circle")
                }
                .buttonStyle(.bordered)
            }
        }
    }

    private var areaButtons: some View {
        HStack(spacing: 14) {
            ForEach(NurseryArea.allCases) { area in
                Button {
                    nurseryTourViewModel.selectArea(area)
                    immersiveViewModel.selectArea(area)
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: area.systemImage)
                            .font(.title2)

                        Text(area.title)
                            .font(.caption.bold())
                    }
                    .frame(width: 115, height: 82)
                }
                .buttonStyle(.bordered)
            }
        }
    }

    @ViewBuilder
    private var selectedAreaView: some View {
        switch nurseryTourViewModel.selectedArea {
        case .classroom:
            ClassroomView()
        case .playArea:
            PlayAreaView()
        case .diningArea:
            DiningAreaView()
        case .outdoorGarden:
            OutdoorAreaView()
        case .readingCorner:
            ReadingCornerView()
        case .safetyDesk:
            SafetyDeskPreviewView()
        }
    }
}
