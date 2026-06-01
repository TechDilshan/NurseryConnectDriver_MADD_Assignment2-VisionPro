import SwiftUI

struct SafetyWindowView: View {
    @EnvironmentObject var safetyViewModel: SafetyViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header

                HStack(spacing: 20) {
                    safetyMetricCard(
                        title: "Safety Notices",
                        value: safetyViewModel.totalNoticesText,
                        subtitle: "Parent-facing notices",
                        icon: "doc.text.fill",
                        color: .blue
                    )

                    safetyMetricCard(
                        title: "High Priority",
                        value: safetyViewModel.highPriorityCountText,
                        subtitle: "Important safeguarding notes",
                        icon: "exclamationmark.triangle.fill",
                        color: .red
                    )

                    safetyMetricCard(
                        title: "Compliance",
                        value: "Active",
                        subtitle: "EYFS and safeguarding context",
                        icon: "shield.lefthalf.filled",
                        color: .green
                    )
                }

                selectedNoticePanel

                SafetyDashboardView()
            }
            .padding(32)
        }
        .background(
            LinearGradient(
                colors: [
                    Color.red.opacity(0.10),
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
                Text("Safety Window")
                    .font(.largeTitle.bold())

                Text("A spatial-style safety and compliance view for safeguarding, emergency contacts, and parent trust.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                safetyViewModel.refreshSafetyData()
            } label: {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var selectedNoticePanel: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 14) {
                SectionHeaderView(
                    title: "Selected Safety Notice",
                    subtitle: "Focused information panel for the currently selected notice"
                )

                if let notice = safetyViewModel.selectedNotice {
                    HStack(spacing: 16) {
                        Image(systemName: icon(for: notice.category))
                            .font(.largeTitle)
                            .foregroundStyle(color(for: notice.priority))
                            .frame(width: 64, height: 64)
                            .background(color(for: notice.priority).opacity(0.14))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 6) {
                            Text(notice.title)
                                .font(.title2.bold())

                            Text(notice.category.title)
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            Text(notice.message)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        StatusBadgeView(
                            title: notice.priority.title,
                            color: color(for: notice.priority)
                        )
                    }
                } else {
                    EmptyStateView(
                        title: "No Notice Selected",
                        message: "Select a notice from the safety dashboard.",
                        systemImage: "doc.text.magnifyingglass"
                    )
                }
            }
        }
    }

    private func safetyMetricCard(
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

    private func color(for priority: SafetyPriority) -> Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }

    private func icon(for category: SafetyCategory) -> String {
        switch category {
        case .safeguarding:
            return "shield.lefthalf.filled"
        case .transport:
            return "bus.fill"
        case .health:
            return "cross.case.fill"
        case .emergency:
            return "phone.fill"
        case .compliance:
            return "doc.text.fill"
        }
    }
}
