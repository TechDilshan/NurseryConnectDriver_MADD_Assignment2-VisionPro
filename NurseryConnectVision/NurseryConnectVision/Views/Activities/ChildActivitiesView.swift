import SwiftUI

struct ChildActivitiesView: View {

    @StateObject private var activityViewModel =
        ChildActivityViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                SectionHeaderView(
                    title: "Child Activities",
                    subtitle: "Daily learning experiences and nursery engagement"
                )

                ActivityTimelineView(
                    activities: activityViewModel.activities
                )

                MealScheduleView(
                    meals: activityViewModel.meals
                )

                AttendanceView()

                EventCalendarView(
                    events: activityViewModel.events
                )
            }
            .padding(30)
        }
    }
}
