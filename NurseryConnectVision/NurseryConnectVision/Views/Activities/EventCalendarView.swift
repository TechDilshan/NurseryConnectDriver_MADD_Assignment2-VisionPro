import SwiftUI

struct EventCalendarView: View {

    let events: [NurseryEvent]

    var body: some View {

        GlassCardView {

            VStack(alignment: .leading, spacing: 16) {

                Text("Upcoming Events")
                    .font(.title2.bold())

                ForEach(events) { event in

                    HStack {

                        Image(systemName: event.area.systemImage)
                            .foregroundStyle(.purple)

                        VStack(alignment: .leading) {

                            Text(event.title)
                                .font(.headline)

                            Text(event.description)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }

                    Divider()
                }
            }
        }
    }
}
