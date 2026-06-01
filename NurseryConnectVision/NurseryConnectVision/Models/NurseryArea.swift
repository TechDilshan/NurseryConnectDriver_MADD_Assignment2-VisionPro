import Foundation

enum NurseryArea: String, CaseIterable, Codable, Identifiable, Hashable {
    case classroom
    case playArea
    case diningArea
    case outdoorGarden
    case readingCorner
    case safetyDesk

    var id: String { rawValue }

    var title: String {
        switch self {
        case .classroom:
            return "Classroom"
        case .playArea:
            return "Play Area"
        case .diningArea:
            return "Dining Area"
        case .outdoorGarden:
            return "Outdoor Garden"
        case .readingCorner:
            return "Reading Corner"
        case .safetyDesk:
            return "Safety Desk"
        }
    }

    var description: String {
        switch self {
        case .classroom:
            return "Learning area for guided activities, early literacy, numeracy, and group work."
        case .playArea:
            return "Interactive play space designed to support social development and physical movement."
        case .diningArea:
            return "Meal space where children receive age-appropriate food and allergen-aware supervision."
        case .outdoorGarden:
            return "Outdoor area for supervised free play, movement, and nature-based activities."
        case .readingCorner:
            return "Quiet literacy corner for storytelling, books, and calm individual activities."
        case .safetyDesk:
            return "Safeguarding information area with emergency contacts and safety notices."
        }
    }

    var systemImage: String {
        switch self {
        case .classroom:
            return "studentdesk"
        case .playArea:
            return "figure.play"
        case .diningArea:
            return "fork.knife"
        case .outdoorGarden:
            return "leaf.fill"
        case .readingCorner:
            return "book.fill"
        case .safetyDesk:
            return "shield.lefthalf.filled"
        }
    }

    var assetName: String {
        switch self {
        case .classroom:
            return "Classroom"
        case .playArea:
            return "Playground"
        case .diningArea:
            return "DiningRoom"
        case .outdoorGarden:
            return "Garden"
        case .readingCorner:
            return "ReadingCorner"
        case .safetyDesk:
            return "SafetyDesk"
        }
    }
}
