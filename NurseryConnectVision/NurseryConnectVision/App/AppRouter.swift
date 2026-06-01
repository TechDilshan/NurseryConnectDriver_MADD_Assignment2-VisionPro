import Foundation

enum AppRoute: String, CaseIterable, Hashable {

    case dashboard
    case nurseryTour
    case transport
    case safety

    var title: String {
        switch self {

        case .dashboard:
            return "Dashboard"

        case .nurseryTour:
            return "Nursery Tour"

        case .transport:
            return "Transport"

        case .safety:
            return "Safety"
        }
    }
}
