import SwiftUI

struct VehicleStatusView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "bus.fill")
                    .font(.system(size: 46))
                    .foregroundStyle(.orange)

                Spacer()

                Text(transportViewModel.isTrackingActive ? "Active" : "Completed")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(statusColor.opacity(0.16))
                    .foregroundStyle(statusColor)
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Vehicle Status")
                    .font(.title.bold())

                Text("Vehicle \(transportViewModel.vehicleNumberText)")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(transportViewModel.vehicleStatus.currentLocationDescription)
                    .font(.headline)
                    .foregroundStyle(.blue)
            }

            Divider()

            HStack {
                metricView(
                    title: "Children",
                    value: transportViewModel.childrenOnBoardText,
                    icon: "person.3.fill"
                )

                Spacer()

                metricView(
                    title: "Progress",
                    value: transportViewModel.routeProgressText,
                    icon: "map.fill"
                )
            }
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private var statusColor: Color {
        transportViewModel.isTrackingActive ? .green : .gray
    }

    private func metricView(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(.orange)

            Text(value)
                .font(.title2.bold())

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
