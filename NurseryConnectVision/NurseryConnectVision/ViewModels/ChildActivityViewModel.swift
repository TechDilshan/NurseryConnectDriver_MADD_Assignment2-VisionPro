import Foundation
import SwiftUI

@MainActor
final class ChildActivityViewModel: ObservableObject {

    @Published var activities: [DailyActivity]
    @Published var meals: [ChildMeal]
    @Published var events: [NurseryEvent]
    @Published var selectedArea: NurseryArea? = nil

    private let dataService: MockDataService

    init(dataService: MockDataService = .shared) {
        self.dataService = dataService
        self.activities = dataService.sampleActivities()
        self.meals = dataService.sampleMeals()
        self.events = dataService.sampleEvents()
    }

    var filteredActivities: [DailyActivity] {
        guard let selectedArea else {
            return activities
        }

        return activities.filter { $0.area == selectedArea }
    }

    var todaySummaryText: String {
        "\(activities.count) activities, \(meals.count) meal records, \(events.count) upcoming events"
    }

    func selectArea(_ area: NurseryArea?) {
        withAnimation(.easeInOut) {
            selectedArea = area
        }
    }

    func refresh() {
        activities = dataService.sampleActivities()
        meals = dataService.sampleMeals()
        events = dataService.sampleEvents()
    }
}
