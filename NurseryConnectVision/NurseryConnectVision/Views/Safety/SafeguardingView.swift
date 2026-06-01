import SwiftUI

struct SafeguardingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 44))
                    .foregroundStyle(.blue)

                Spacer()

                Text("Active")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.green.opacity(0.15))
                    .foregroundStyle(.green)
                    .clipShape(Capsule())
            }

            Text("Safeguarding")
                .font(.title2.bold())

            Text("NurseryConnect Vision presents safeguarding information clearly in a spatial parent experience.")
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 10) {
                policyRow("Named keyworker system")
                policyRow("Transport visibility")
                policyRow("Incident escalation")
                policyRow("Emergency contacts")
            }
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func policyRow(_ text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)

            Text(text)
                .font(.subheadline)

            Spacer()
        }
    }
}
