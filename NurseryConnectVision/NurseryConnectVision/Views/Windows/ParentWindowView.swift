import SwiftUI

struct ParentWindowView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header

                HStack(spacing: 20) {
                    summaryCard(
                        title: "Selected Child",
                        value: parentDashboardViewModel.childNameText,
                        subtitle: parentDashboardViewModel.childRoomText,
                        icon: "person.crop.circle.fill",
                        color: .blue
                    )

                    summaryCard(
                        title: "Transport",
                        value: parentDashboardViewModel.transportStatusText,
                        subtitle: "ETA \(transportViewModel.etaText)",
                        icon: "bus.fill",
                        color: .orange
                    )

                    summaryCard(
                        title: "Attendance",
                        value: parentDashboardViewModel.attendanceStatusText,
                        subtitle: "Daily nursery status",
                        icon: "checkmark.circle.fill",
                        color: .green
                    )
                }

                childSelector

                ParentDashboardView()

                ChildActivitiesView()
            }
            .padding(32)
        }
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.12),
                    Color.purple.opacity(0.08),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Parent Spatial Dashboard")
                    .font(.largeTitle.bold())

                Text("A parent-facing visionOS extension of NurseryConnect, showing child care, transport, and nursery updates.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text("Part B")
                    .font(.headline)

                Text("visionOS Prototype")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 22))
        }
    }

    private var childSelector: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeaderView(
                    title: "Child Selector",
                    subtitle: "Select a child to update the parent dashboard"
                )

                HStack(spacing: 14) {
                    ForEach(parentDashboardViewModel.parent.children) { child in
                        Button {
                            parentDashboardViewModel.selectChild(child)
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.blue)

                                Text(child.preferredName)
                                    .font(.headline)

                                Text(child.roomName)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 160, height: 130)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }

    private func summaryCard(
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
                .font(.title2.bold())

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
