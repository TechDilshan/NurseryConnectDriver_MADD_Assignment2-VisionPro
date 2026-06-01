import SwiftUI

struct TransportCard: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "bus.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(.orange)

                Spacer()

                Text(transportViewModel.trackingStatusTitle)
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange.opacity(0.15))
                    .foregroundStyle(.orange)
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Vehicle \(transportViewModel.vehicleNumberText)")
                    .font(.title2.bold())

                Text("Driver: \(transportViewModel.driverNameText)")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text("ETA: \(transportViewModel.etaText)")
                    .font(.headline)
                    .foregroundStyle(.blue)
            }

            ProgressView(value: transportViewModel.vehicleStatus.routeProgress)
                .progressViewStyle(.linear)

            HStack {
                Text("Progress")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Text(transportViewModel.routeProgressText)
                    .font(.caption.bold())
            }

            Button {
                transportViewModel.advanceRouteProgress()
            } label: {
                Label("Update Route Progress", systemImage: "arrow.clockwise")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
