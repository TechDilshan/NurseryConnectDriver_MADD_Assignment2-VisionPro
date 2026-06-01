import SwiftUI

struct AttendanceView: View {

    var body: some View {

        GlassCardView {

            VStack(alignment: .leading, spacing: 18) {

                Text("Attendance")
                    .font(.title2.bold())

                HStack {

                    attendanceCard(
                        title: "Checked In",
                        value: "08:15 AM",
                        color: .green
                    )

                    attendanceCard(
                        title: "Checked Out",
                        value: "--",
                        color: .orange
                    )
                }
            }
        }
    }

    private func attendanceCard(
        title: String,
        value: String,
        color: Color
    ) -> some View {

        VStack {

            Text(value)
                .font(.title2.bold())

            Text(title)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            color.opacity(0.12)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }
}
