import SwiftUI

// MARK: - NurseryArea Theme Extension

extension NurseryArea {
    var themeColor: Color {
        switch self {
        case .classroom:     return .blue
        case .playArea:      return .orange
        case .diningArea:    return .green
        case .outdoorGarden: return .mint
        case .readingCorner: return .purple
        case .safetyDesk:    return .red
        }
    }

    var themeGradient: [Color] {
        switch self {
        case .classroom:     return [.blue.opacity(0.8), .cyan.opacity(0.5)]
        case .playArea:      return [.orange.opacity(0.8), .yellow.opacity(0.5)]
        case .diningArea:    return [.green.opacity(0.8), .mint.opacity(0.5)]
        case .outdoorGarden: return [.mint.opacity(0.8), .green.opacity(0.5)]
        case .readingCorner: return [.purple.opacity(0.8), .indigo.opacity(0.5)]
        case .safetyDesk:    return [.red.opacity(0.8), .orange.opacity(0.5)]
        }
    }

    var description: String {
        switch self {
        case .classroom:
            return "Bright, Montessori-inspired learning environment with alphabet displays, art corners, and cozy reading nooks."
        case .playArea:
            return "Vibrant supervised space featuring climbing frames, sensory toys, and open floor space for social development."
        case .diningArea:
            return "Colourful dining hall with low tables, nutritional meal displays, and allergy-aware seating arrangements."
        case .outdoorGarden:
            return "Secure outdoor garden with raised planters, mud kitchen, and open grass area for fresh air and exploration."
        case .readingCorner:
            return "Quiet library nook with cushioned seating, age-sorted bookshelves, and soft ambient lighting."
        case .safetyDesk:
            return "Central safeguarding hub with CCTV monitors, visitor log, emergency contacts, and first-aid station."
        }
    }

    var highlights: [String] {
        switch self {
        case .classroom:     return ["12 children max", "Qualified teacher", "EYFS curriculum", "Interactive boards"]
        case .playArea:      return ["Padded flooring", "CCTV monitored", "Age 2–5 toys", "Daily sanitised"]
        case .diningArea:    return ["Fresh daily meals", "Allergy menus", "Highchair available", "Dietitian approved"]
        case .outdoorGarden: return ["Fully fenced", "Shade canopy", "Garden sessions", "Weather permitting"]
        case .readingCorner: return ["500+ books", "Bilingual titles", "Story time 10am", "Quiet zone"]
        case .safetyDesk:    return ["DBS checked staff", "CCTV 24/7", "Fire drill monthly", "Ofsted compliant"]
        }
    }
}
