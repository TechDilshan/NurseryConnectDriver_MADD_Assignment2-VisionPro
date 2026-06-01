import SwiftUI

struct ArrivalEstimateView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "timer")
                    .font(.system(size: 46))
                    .foregroundStyle(.blue)

                Spacer()

                Text(transportViewModel.etaText)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.blue)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Estimated Arrival")
                    .font(.title.bold())

                Text(transportViewModel.trackingStatusSubtitle)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Divider()

            Text(transportViewModel.statusMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button {
                transportViewModel.resetTracking()
            } label: {
                Label("Reset Tracking", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
