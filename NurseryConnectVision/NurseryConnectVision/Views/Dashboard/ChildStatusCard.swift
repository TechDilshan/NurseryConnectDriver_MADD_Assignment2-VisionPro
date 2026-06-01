import SwiftUI

struct ChildStatusCard: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 46))
                    .foregroundStyle(.blue)

                Spacer()

                Text(parentDashboardViewModel.transportStatusText)
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.green.opacity(0.15))
                    .foregroundStyle(.green)
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(parentDashboardViewModel.childNameText)
                    .font(.title.bold())

                Text(parentDashboardViewModel.childRoomText)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text("Keyworker: \(parentDashboardViewModel.keyworkerText)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Divider()

            Text("This card gives parents a calm, at-a-glance summary of their child’s current nursery and transport status.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
