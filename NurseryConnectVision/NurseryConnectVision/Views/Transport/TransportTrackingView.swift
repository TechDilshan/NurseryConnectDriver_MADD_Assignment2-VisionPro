import SwiftUI

struct TransportTrackingView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection

                HStack(spacing: 20) {
                    VehicleStatusView()
                        .frame(maxWidth: .infinity)

                    ArrivalEstimateView()
                        .frame(maxWidth: .infinity)
                }

                RouteProgressView()

                DriverInformationView()

                privacyNote
            }
            .padding(32)
        }
        .background(
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.14),
                    Color.blue.opacity(0.08),
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
                Text("Spatial Transport Tracking")
                    .font(.largeTitle.bold())

                Text("Parent-facing transport view extended from the Part A driver operations system.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                transportViewModel.advanceRouteProgress()
            } label: {
                Label("Update Route", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var privacyNote: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Privacy Note", systemImage: "lock.shield.fill")
                .font(.headline)

            Text("This prototype shows approximate transport progress for parents. A production NurseryConnect system would limit location precision, apply consent rules, and retain GPS data only for a defined safeguarding period.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
