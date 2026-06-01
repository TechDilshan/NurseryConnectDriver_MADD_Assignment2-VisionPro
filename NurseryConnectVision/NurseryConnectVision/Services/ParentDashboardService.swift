import Foundation

protocol ParentDashboardServiceProtocol {
    func loadParent() -> Parent
    func loadSelectedChild() -> Child?
    func loadEvents() -> [NurseryEvent]
}

final class ParentDashboardService: ParentDashboardServiceProtocol {
    func loadParent() -> Parent {
        MockDataService.shared.sampleParent()
    }

    func loadSelectedChild() -> Child? {
        MockDataService.shared.sampleChildren().first
    }

    func loadEvents() -> [NurseryEvent] {
        MockDataService.shared.sampleEvents()
    }
}
