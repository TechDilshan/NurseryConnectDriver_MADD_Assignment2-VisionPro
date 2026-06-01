import SwiftUI

struct ParentRolePrototypeView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        PrototypePurposeScreen(
            purpose: .parentRole,
            headline: "Parent-facing spatial dashboard",
            summary: "This prototype extends NurseryConnect for parents on Apple Vision Pro. It surfaces child status, attendance, meals, activities, and transport in calm spatial windows—not driver or staff workflows.",
            onOpenFeature: { parentDashboardViewModel.openLinkedFeature(for: .parentRole) }
        ) {
            HStack(spacing: 16) {
                PrototypeMetricPill(
                    label: "Children linked",
                    value: "\(parentDashboardViewModel.parent.children.count)",
                    icon: "person.3.fill",
                    color: .blue
                )
                PrototypeMetricPill(
                    label: "Selected child",
                    value: parentDashboardViewModel.childNameText,
                    icon: "person.crop.circle.fill",
                    color: .cyan
                )
                PrototypeMetricPill(
                    label: "Attendance",
                    value: parentDashboardViewModel.attendanceStatusText,
                    icon: "checkmark.circle.fill",
                    color: .green
                )
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeaderView(
                        title: "What parents can do",
                        subtitle: "Core capabilities demonstrated in this build"
                    )

                    PrototypeFeatureRow(
                        icon: "rectangle.grid.2x2.fill",
                        title: "Daily dashboard",
                        detail: "View attendance, meals, activities, and nursery events for the selected child.",
                        color: .blue
                    )
                    PrototypeFeatureRow(
                        icon: "person.crop.circle.badge.checkmark",
                        title: "Multi-child households",
                        detail: "Switch between children to update cards and timelines without leaving spatial UI.",
                        color: .indigo
                    )
                    PrototypeFeatureRow(
                        icon: "bell.badge.fill",
                        title: "Calm status summaries",
                        detail: "At-a-glance cards reduce anxiety—check-in state, keyworker, and room are always visible.",
                        color: .teal
                    )
                    PrototypeFeatureRow(
                        icon: "lock.shield.fill",
                        title: "Parent-only data",
                        detail: "Prototype shows parent-safe summaries; staff/driver tools live in separate driver app.",
                        color: .mint
                    )
                }
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeaderView(
                        title: "Live preview",
                        subtitle: "Current parent session"
                    )
                    Label(parentDashboardViewModel.parentGreeting, systemImage: "hand.wave.fill")
                        .font(.headline)
                    Label("Keyworker: \(parentDashboardViewModel.keyworkerText)", systemImage: "person.fill.checkmark")
                        .foregroundStyle(.secondary)
                    Label("Transport: \(parentDashboardViewModel.transportStatusText)", systemImage: "bus.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
