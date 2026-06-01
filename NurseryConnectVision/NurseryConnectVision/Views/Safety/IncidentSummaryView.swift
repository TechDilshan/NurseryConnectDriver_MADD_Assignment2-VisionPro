import SwiftUI

struct IncidentSummaryView: View {
    @EnvironmentObject var safetyViewModel: SafetyViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.orange)

                Spacer()

                Text(safetyViewModel.highPriorityCountText)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)
            }

            Text("Incident Summary")
                .font(.title2.bold())

            Text("High priority notices are highlighted for quick parent and management awareness.")
                .foregroundStyle(.secondary)

            if safetyViewModel.highPriorityNotices.isEmpty {
                Text("No high-priority incidents.")
                    .font(.headline)
                    .foregroundStyle(.green)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            } else {
                ForEach(safetyViewModel.highPriorityNotices) { notice in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(notice.title)
                            .font(.headline)

                        Text(notice.message)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color.red.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
