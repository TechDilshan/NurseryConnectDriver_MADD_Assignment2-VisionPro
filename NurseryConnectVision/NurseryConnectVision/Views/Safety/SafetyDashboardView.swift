import SwiftUI

struct SafetyDashboardView: View {
    @EnvironmentObject var safetyViewModel: SafetyViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection

                HStack(spacing: 20) {
                    SafeguardingView()
                        .frame(maxWidth: .infinity)

                    EmergencyContactsView()
                        .frame(maxWidth: .infinity)
                }

                HStack(spacing: 20) {
                    IncidentSummaryView()
                        .frame(maxWidth: .infinity)

                    ComplianceView()
                        .frame(maxWidth: .infinity)
                }

                noticeListSection
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

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Safety & Compliance Center")
                    .font(.largeTitle.bold())

                Text("Spatial parent-facing view for safeguarding, emergency, and compliance information.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text("\(safetyViewModel.highPriorityNotices.count)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)

                Text("High Priority")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 22))
        }
    }

    private var noticeListSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Safety Notices")
                .font(.title2.bold())

            Picker("Category", selection: Binding<SafetyCategory?>(
                get: { safetyViewModel.selectedCategory },
                set: { safetyViewModel.selectCategory($0) }
            )) {
                Text("All").tag(SafetyCategory?.none)

                ForEach(SafetyCategory.allCases, id: \.self) { category in
                    Text(category.title).tag(Optional(category))
                }
            }
            .pickerStyle(.segmented)

            ForEach(safetyViewModel.filteredNotices) { notice in
                Button {
                    safetyViewModel.selectNotice(notice)
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: noticeIcon(for: notice))
                            .font(.title2)
                            .foregroundStyle(priorityColor(for: notice.priority))
                            .frame(width: 48, height: 48)
                            .background(priorityColor(for: notice.priority).opacity(0.14))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(notice.title)
                                .font(.headline)

                            Text(notice.message)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }

                        Spacer()

                        Text(notice.priority.title)
                            .font(.caption.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(priorityColor(for: notice.priority).opacity(0.14))
                            .foregroundStyle(priorityColor(for: notice.priority))
                            .clipShape(Capsule())
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func priorityColor(for priority: SafetyPriority) -> Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }

    private func noticeIcon(for notice: SafetyNotice) -> String {
        switch notice.category {
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
