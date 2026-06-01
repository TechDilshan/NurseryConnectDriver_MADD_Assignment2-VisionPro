import Foundation

struct ChildMeal: Identifiable, Codable, Hashable {
    let id: UUID
    var mealType: MealType
    var foodDescription: String
    var portionConsumed: PortionConsumed
    var notes: String

    init(
        id: UUID = UUID(),
        mealType: MealType,
        foodDescription: String,
        portionConsumed: PortionConsumed,
        notes: String = ""
    ) {
        self.id = id
        self.mealType = mealType
        self.foodDescription = foodDescription
        self.portionConsumed = portionConsumed
        self.notes = notes
    }
}

enum MealType: String, Codable, CaseIterable, Hashable {
    case breakfast
    case morningSnack
    case lunch
    case afternoonSnack

    var title: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .morningSnack:
            return "Morning Snack"
        case .lunch:
            return "Lunch"
        case .afternoonSnack:
            return "Afternoon Snack"
        }
    }
}

enum PortionConsumed: String, Codable, CaseIterable, Hashable {
    case all
    case most
    case half
    case little
    case none

    var title: String {
        switch self {
        case .all:
            return "All"
        case .most:
            return "Most"
        case .half:
            return "Half"
        case .little:
            return "Little"
        case .none:
            return "None"
        }
    }
}
