import SwiftUI

struct AttendanceCard: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(.green)

                Spacer()

                Text(parentDashboardViewModel.attendanceStatusText)
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.green.opacity(0.15))
                    .foregroundStyle(.green)
                    .clipShape(Capsule())
            }

            Text("Attendance")
                .font(.title2.bold())

            if let child = parentDashboardViewModel.selectedChild {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Check In: \(formattedTime(child.attendance.checkInTime))")
                    Text("Check Out: \(formattedTime(child.attendance.checkOutTime))")
                }
                .font(.headline)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Text("Attendance status supports parent visibility and safeguarding awareness.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func formattedTime(_ date: Date?) -> String {
        guard let date else { return "Not available" }

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
}
