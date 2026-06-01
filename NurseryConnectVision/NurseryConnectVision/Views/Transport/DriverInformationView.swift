import SwiftUI

struct DriverInformationView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "person.badge.shield.checkmark.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.blue)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Driver Information")
                        .font(.title2.bold())

                    Text("Transport staff details visible to parents during an active route.")
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }

            HStack(spacing: 16) {
                infoCard(
                    title: "Driver",
                    value: transportViewModel.driverNameText,
                    icon: "person.fill"
                )

                infoCard(
                    title: "Vehicle",
                    value: transportViewModel.vehicleNumberText,
                    icon: "car.fill"
                )

                infoCard(
                    title: "Location Mode",
                    value: transportViewModel.showParentApproximateLocation ? "Approximate" : "Hidden",
                    icon: "location.circle.fill"
                )
            }

            Toggle(
                "Show approximate location to parent",
                isOn: $transportViewModel.showParentApproximateLocation
            )
            .font(.headline)

            Text("This toggle demonstrates privacy-aware parent visibility. A real system would be controlled by nursery policy, consent, and safeguarding rules.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func infoCard(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(.blue)

            Text(value)
                .font(.headline)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
