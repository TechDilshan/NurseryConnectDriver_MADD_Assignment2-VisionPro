import Foundation

protocol TransportServiceProtocol {
    func currentVehicleStatus() -> VehicleStatus
    func updateProgress(from status: VehicleStatus) -> VehicleStatus
}

final class TransportService: TransportServiceProtocol {
    func currentVehicleStatus() -> VehicleStatus {
        MockDataService.shared.sampleVehicleStatus()
    }

    func updateProgress(from status: VehicleStatus) -> VehicleStatus {
        var updatedStatus = status

        let newProgress = min(status.routeProgress + 0.1, 1.0)
        updatedStatus.routeProgress = newProgress
        updatedStatus.estimatedArrivalMinutes = max(status.estimatedArrivalMinutes - 1, 0)

        if newProgress >= 1.0 {
            updatedStatus.isActive = false
            updatedStatus.currentLocationDescription = "Arrived at Little Stars Nursery"
        }

        return updatedStatus
    }
}
