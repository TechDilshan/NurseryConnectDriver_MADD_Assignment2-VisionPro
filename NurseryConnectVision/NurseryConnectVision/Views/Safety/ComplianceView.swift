import SwiftUI

struct ComplianceView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.purple)

                Spacer()

                Text("Parent View")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.purple.opacity(0.15))
                    .foregroundStyle(.purple)
                    .clipShape(Capsule())
            }

            Text("Compliance Awareness")
                .font(.title2.bold())

            complianceRow(
                title: "UK GDPR",
                text: "Only parent-facing child and transport summaries are shown."
            )

            complianceRow(
                title: "EYFS 2024",
                text: "Supports child safety, welfare visibility, and parent engagement."
            )

            complianceRow(
                title: "Ofsted",
                text: "Shows structured safety and operational information."
            )

            complianceRow(
                title: "Children Act 1989",
                text: "Prioritises child welfare and safeguarding communication."
            )
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func complianceRow(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)

            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
