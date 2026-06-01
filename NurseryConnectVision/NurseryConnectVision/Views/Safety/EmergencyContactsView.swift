import SwiftUI

struct EmergencyContactsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "phone.circle.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.red)

                Spacer()
            }

            Text("Emergency Contacts")
                .font(.title2.bold())

            contactRow(
                title: "Nursery Office",
                value: "020 1234 5678",
                icon: "building.2.fill"
            )

            contactRow(
                title: "Designated Safeguarding Lead",
                value: "Ms. Harper",
                icon: "shield.fill"
            )

            contactRow(
                title: "Transport Coordinator",
                value: "Driver Desk",
                icon: "bus.fill"
            )

            Text("A production system would use verified phone numbers and role-based emergency escalation procedures.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func contactRow(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(.red)
                .frame(width: 36, height: 36)
                .background(Color.red.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)

                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
