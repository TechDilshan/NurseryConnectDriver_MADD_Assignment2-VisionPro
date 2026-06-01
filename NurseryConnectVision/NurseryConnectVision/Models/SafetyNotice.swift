import Foundation

struct SafetyNotice: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var message: String
    var category: SafetyCategory
    var priority: SafetyPriority
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        category: SafetyCategory,
        priority: SafetyPriority,
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.category = category
        self.priority = priority
        self.updatedAt = updatedAt
    }
}

enum SafetyCategory: String, Codable, CaseIterable, Hashable {
    case safeguarding
    case transport
    case health
    case emergency
    case compliance

    var title: String {
        switch self {
        case .safeguarding:
            return "Safeguarding"
        case .transport:
            return "Transport"
        case .health:
            return "Health"
        case .emergency:
            return "Emergency"
        case .compliance:
            return "Compliance"
        }
    }
}

enum SafetyPriority: String, Codable, CaseIterable, Hashable {
    case low
    case medium
    case high

    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}
