import Foundation

protocol SafetyServiceProtocol {
    func loadSafetyNotices() -> [SafetyNotice]
    func highPriorityNotices(from notices: [SafetyNotice]) -> [SafetyNotice]
}

final class SafetyService: SafetyServiceProtocol {
    func loadSafetyNotices() -> [SafetyNotice] {
        MockDataService.shared.sampleSafetyNotices()
    }

    func highPriorityNotices(from notices: [SafetyNotice]) -> [SafetyNotice] {
        notices.filter { $0.priority == .high }
    }
}
