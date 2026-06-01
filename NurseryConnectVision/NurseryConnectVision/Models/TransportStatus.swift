import Foundation

enum TransportStatus: String, Codable, CaseIterable, Hashable {
    case waitingForPickup
    case boarded
    case inTransit
    case arrivedAtNursery
    case completed

    var title: String {
        switch self {
        case .waitingForPickup:
            return "Waiting for Pickup"
        case .boarded:
            return "Boarded"
        case .inTransit:
            return "In Transit"
        case .arrivedAtNursery:
            return "Arrived at Nursery"
        case .completed:
            return "Completed"
        }
    }

    var systemImage: String {
        switch self {
        case .waitingForPickup:
            return "clock.fill"
        case .boarded:
            return "person.crop.circle.badge.checkmark"
        case .inTransit:
            return "bus.fill"
        case .arrivedAtNursery:
            return "building.2.fill"
        case .completed:
            return "checkmark.seal.fill"
        }
    }
}
