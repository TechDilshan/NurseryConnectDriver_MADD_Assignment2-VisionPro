import Foundation

/// MADD Assignment 2 prototype pillars shown in the Vision app sidebar.
enum PrototypePurpose: String, CaseIterable, Identifiable, Hashable {
    case parentRole
    case spatialTour
    case transportExtension

    var id: String { rawValue }

    var title: String {
        switch self {
        case .parentRole: return "Parent Role"
        case .spatialTour: return "Spatial Tour"
        case .transportExtension: return "Transport Extension"
        }
    }

    var systemImage: String {
        switch self {
        case .parentRole: return "person.2.fill"
        case .spatialTour: return "visionpro"
        case .transportExtension: return "bus.fill"
        }
    }

    var accentColorName: String {
        switch self {
        case .parentRole: return "blue"
        case .spatialTour: return "purple"
        case .transportExtension: return "orange"
        }
    }

    var linkedRoute: AppRoute {
        switch self {
        case .parentRole: return .dashboard
        case .spatialTour: return .nurseryTour
        case .transportExtension: return .transport
        }
    }
}
