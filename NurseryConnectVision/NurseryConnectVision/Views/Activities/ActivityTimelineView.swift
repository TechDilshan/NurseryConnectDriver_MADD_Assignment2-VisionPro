import SwiftUI

struct ActivityTimelineView: View {

    let activities: [DailyActivity]

    var body: some View {

        GlassCardView {

            VStack(alignment: .leading, spacing: 16) {

                Text("Activity Timeline")
                    .font(.title2.bold())

                ForEach(activities) { activity in

                    HStack(alignment: .top, spacing: 16) {

                        Image(systemName: activity.area.systemImage)
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading) {

                            Text(activity.title)
                                .font(.headline)

                            Text(activity.description)
                                .foregroundStyle(.secondary)

                            Text(activity.eyfsArea)
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                    }

                    Divider()
                }
            }
        }
    }
}
