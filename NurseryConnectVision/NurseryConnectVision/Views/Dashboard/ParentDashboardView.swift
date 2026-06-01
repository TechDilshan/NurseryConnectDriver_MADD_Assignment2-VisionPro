import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection

                HStack(spacing: 20) {
                    ChildStatusCard()
                        .frame(maxWidth: .infinity)

                    TransportCard()
                        .frame(maxWidth: .infinity)
                }

                HStack(spacing: 20) {
                    AttendanceCard()
                        .frame(maxWidth: .infinity)

                    MealCard()
                        .frame(maxWidth: .infinity)
                }

                DailySummaryCard()

                upcomingEventsSection
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

    private var headerSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8) {
                Text(parentDashboardViewModel.parentGreeting)
                    .font(.largeTitle.bold())

                Text("Explore your child’s nursery day through a spatial parent dashboard.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text("NurseryConnect Vision")
                    .font(.headline)

                Text("Parent Experience")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

    private var upcomingEventsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Upcoming Nursery Events")
                .font(.title2.bold())

            ForEach(parentDashboardViewModel.events) { event in
                HStack(spacing: 16) {
                    Image(systemName: event.area.systemImage)
                        .font(.title2)
                        .foregroundStyle(.blue)
                        .frame(width: 48, height: 48)
                        .background(Color.blue.opacity(0.15))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                            .font(.headline)

                        Text(event.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}
