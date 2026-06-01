import Foundation

struct VehicleStatus: Identifiable, Codable, Hashable {
    let id: UUID
    var vehicleNumber: String
    var driverName: String
    var currentLocationDescription: String
    var estimatedArrivalMinutes: Int
    var childrenOnBoard: Int
    var totalChildren: Int
    var routeProgress: Double
    var isActive: Bool

    init(
        id: UUID = UUID(),
        vehicleNumber: String,
        driverName: String,
        currentLocationDescription: String,
        estimatedArrivalMinutes: Int,
        childrenOnBoard: Int,
        totalChildren: Int,
        routeProgress: Double,
        isActive: Bool
    ) {
        self.id = id
        self.vehicleNumber = vehicleNumber
        self.driverName = driverName
        self.currentLocationDescription = currentLocationDescription
        self.estimatedArrivalMinutes = estimatedArrivalMinutes
        self.childrenOnBoard = childrenOnBoard
        self.totalChildren = totalChildren
        self.routeProgress = routeProgress
        self.isActive = isActive
    }

    var etaText: String {
        "\(estimatedArrivalMinutes) min"
    }

    var progressText: String {
        "\(Int(routeProgress * 100))%"
    }
}
