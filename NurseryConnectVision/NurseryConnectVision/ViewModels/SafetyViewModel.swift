import Foundation
import SwiftUI

@MainActor
final class SafetyViewModel: ObservableObject {

    @Published var safetyNotices: [SafetyNotice]
    @Published var selectedCategory: SafetyCategory? = nil
    @Published var selectedNotice: SafetyNotice?

    private let service: SafetyServiceProtocol

    init(service: SafetyServiceProtocol = SafetyService()) {
        self.service = service
        self.safetyNotices = service.loadSafetyNotices()
        self.selectedNotice = service.loadSafetyNotices().first
    }

    var highPriorityNotices: [SafetyNotice] {
        service.highPriorityNotices(from: safetyNotices)
    }

    var filteredNotices: [SafetyNotice] {
        guard let selectedCategory else {
            return safetyNotices
        }

        return safetyNotices.filter { $0.category == selectedCategory }
    }

    var highPriorityCountText: String {
        "\(highPriorityNotices.count)"
    }

    var totalNoticesText: String {
        "\(safetyNotices.count)"
    }

    func selectCategory(_ category: SafetyCategory?) {
        withAnimation(.easeInOut) {
            selectedCategory = category
        }
    }

    func selectNotice(_ notice: SafetyNotice) {
        withAnimation(.easeInOut) {
            selectedNotice = notice
        }
    }

    func refreshSafetyData() {
        safetyNotices = service.loadSafetyNotices()
        selectedNotice = safetyNotices.first
    }
}
