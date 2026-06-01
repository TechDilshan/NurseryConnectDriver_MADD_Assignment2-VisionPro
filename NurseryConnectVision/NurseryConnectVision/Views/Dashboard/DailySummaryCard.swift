import SwiftUI

struct DailySummaryCard: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Daily Learning Summary")
                        .font(.title2.bold())

                    Text("A parent-friendly overview of today’s activities.")
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "sparkles")
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
            }

            ForEach(parentDashboardViewModel.latestActivities) { activity in
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: activity.area.systemImage)
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .frame(width: 42, height: 42)
                        .background(Color.blue.opacity(0.15))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.title)
                            .font(.headline)

                        Text(activity.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text("EYFS Area: \(activity.eyfsArea)")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }

                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
