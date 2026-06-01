import Foundation
import SwiftUI

@MainActor
final class ParentDashboardViewModel: ObservableObject {

    @Published var parent: Parent
    @Published var selectedChild: Child?
    @Published var events: [NurseryEvent]
    @Published var selectedRoute: AppRoute = .dashboard
    @Published var selectedPrototypePurpose: PrototypePurpose?

    private let service: ParentDashboardServiceProtocol

    init(service: ParentDashboardServiceProtocol = ParentDashboardService()) {
        self.service = service
        self.parent = service.loadParent()
        self.selectedChild = service.loadSelectedChild()
        self.events = service.loadEvents()
    }

    var parentGreeting: String {
        "Welcome, \(parent.fullName)"
    }

    var childNameText: String {
        selectedChild?.preferredName ?? "No child selected"
    }

    var childRoomText: String {
        selectedChild?.roomName ?? "Room unavailable"
    }

    var keyworkerText: String {
        selectedChild?.keyworkerName ?? "Keyworker unavailable"
    }

    var transportStatusText: String {
        selectedChild?.transportStatus.title ?? "Transport unavailable"
    }

    var attendanceStatusText: String {
        selectedChild?.attendance.currentStatus.title ?? "Attendance unavailable"
    }

    var latestActivities: [DailyActivity] {
        selectedChild?.activities.prefix(3).map { $0 } ?? []
    }

    var latestMeals: [ChildMeal] {
        selectedChild?.meals.prefix(2).map { $0 } ?? []
    }

    func selectChild(_ child: Child) {
        withAnimation(.easeInOut) {
            selectedChild = child
        }
    }

    func selectRoute(_ route: AppRoute) {
        withAnimation(.easeInOut) {
            selectedPrototypePurpose = nil
            selectedRoute = route
        }
    }

    func selectPrototypePurpose(_ purpose: PrototypePurpose) {
        withAnimation(.easeInOut) {
            selectedPrototypePurpose = purpose
        }
    }

    func openLinkedFeature(for purpose: PrototypePurpose) {
        withAnimation(.easeInOut) {
            selectedPrototypePurpose = nil
            selectedRoute = purpose.linkedRoute
        }
    }

    func refreshDashboard() {
        parent = service.loadParent()
        selectedChild = service.loadSelectedChild()
        events = service.loadEvents()
    }
}
