import SwiftUI

struct TourWindowView: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header

                HStack(spacing: 20) {
                    tourMetricCard(
                        title: "Selected Area",
                        value: nurseryTourViewModel.selectedAreaTitle,
                        subtitle: "Current tour focus",
                        icon: nurseryTourViewModel.selectedArea.systemImage,
                        color: .blue
                    )

                    tourMetricCard(
                        title: "Immersive Space",
                        value: immersiveViewModel.isImmersiveSpaceOpen ? "Open" : "Closed",
                        subtitle: "Vision Pro spatial mode",
                        icon: "visionpro",
                        color: immersiveViewModel.isImmersiveSpaceOpen ? .green : .orange
                    )

                    tourMetricCard(
                        title: "Tour Mode",
                        value: "Parent View",
                        subtitle: "Spatial nursery experience",
                        icon: "person.2.fill",
                        color: .purple
                    )
                }

                nurseryAreasPanel

                NurseryTourView()
            }
            .padding(32)
        }
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
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tour Window")
                    .font(.largeTitle.bold())

                Text("A spatial nursery tour where parents explore classrooms, dining, play, and safety areas.")
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

    private var nurseryAreasPanel: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 18) {
                SectionHeaderView(
                    title: "Nursery Areas",
                    subtitle: "Select a space to update both the window preview and immersive view"
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
                            .frame(width: 120, height: 90)
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
