import SwiftUI

struct SpatialTourPrototypeView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        PrototypePurposeScreen(
            purpose: .spatialTour,
            headline: "Immersive nursery walkthrough",
            summary: "Parents explore classroom, play, dining, garden, library, and safety spaces in 3D on Vision Pro—preview in windows, then enter full immersive mode with area navigation.",
            onOpenFeature: { parentDashboardViewModel.openLinkedFeature(for: .spatialTour) }
        ) {
            HStack(spacing: 16) {
                PrototypeMetricPill(
                    label: "Nursery areas",
                    value: "\(NurseryArea.allCases.count)",
                    icon: "building.2.fill",
                    color: .purple
                )
                PrototypeMetricPill(
                    label: "Current preview",
                    value: nurseryTourViewModel.selectedAreaTitle,
                    icon: nurseryTourViewModel.selectedArea.systemImage,
                    color: nurseryTourViewModel.selectedArea.themeColor
                )
                PrototypeMetricPill(
                    label: "Immersive",
                    value: immersiveViewModel.isImmersiveSpaceOpen ? "Active" : "Ready",
                    icon: "visionpro",
                    color: immersiveViewModel.isImmersiveSpaceOpen ? .green : .orange
                )
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeaderView(
                        title: "Spatial tour features",
                        subtitle: "Built for visionOS 1.2"
                    )

                    PrototypeFeatureRow(
                        icon: "cube.transparent.fill",
                        title: "3D area previews",
                        detail: "Each nursery zone has a RealityKit preview card before entering immersive mode.",
                        color: .purple
                    )
                    PrototypeFeatureRow(
                        icon: "play.circle.fill",
                        title: "Start / Stop immersive",
                        detail: "Full spatial experience with a fixed top task bar to switch areas or exit.",
                        color: .green
                    )
                    PrototypeFeatureRow(
                        icon: "figure.2.and.child.holdinghands",
                        title: "Populated scenes",
                        detail: "Classrooms, sports complex, dining, garden, library, and medical safety room include 3D children and equipment.",
                        color: .pink
                    )
                    PrototypeFeatureRow(
                        icon: "signpost.right.fill",
                        title: "Area signage",
                        detail: "Labels such as Swimming pool complex and Nursery Library orient parents in space.",
                        color: .indigo
                    )
                }
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeaderView(
                        title: "Areas included",
                        subtitle: "Tap a chip to preview in the tour window"
                    )

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 10) {
                        ForEach(NurseryArea.allCases) { area in
                            Button {
                                nurseryTourViewModel.selectArea(area)
                            } label: {
                                HStack(spacing: 8) {
                                    Image(systemName: area.systemImage)
                                    Text(area.title)
                                        .font(.caption.bold())
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(area.themeColor.opacity(0.2))
                                .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    Button {
                        Task { await startImmersive() }
                    } label: {
                        Label("Try immersive mode", systemImage: "visionpro.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(immersiveViewModel.isImmersiveSpaceOpen)
                }
            }
        }
    }

    private func startImmersive() async {
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
