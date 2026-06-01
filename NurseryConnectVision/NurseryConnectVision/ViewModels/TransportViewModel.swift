import Foundation
import SwiftUI

@MainActor
final class TransportViewModel: ObservableObject {

    @Published var vehicleStatus: VehicleStatus
    @Published var isTrackingActive: Bool
    @Published var statusMessage: String = "Transport tracking is active."
    @Published var showParentApproximateLocation: Bool = true

    private let service: TransportServiceProtocol

    init(service: TransportServiceProtocol = TransportService()) {
        self.service = service

        let initialStatus = service.currentVehicleStatus()

        self.vehicleStatus = initialStatus
        self.isTrackingActive = initialStatus.isActive
    }

    var vehicleNumberText: String {
        vehicleStatus.vehicleNumber
    }

    var driverNameText: String {
        vehicleStatus.driverName
    }

    var etaText: String {
        vehicleStatus.etaText
    }

    var routeProgressText: String {
        vehicleStatus.progressText
    }

    var childrenOnBoardText: String {
        "\(vehicleStatus.childrenOnBoard)/\(vehicleStatus.totalChildren)"
    }

    var trackingStatusTitle: String {
        isTrackingActive ? "Live Transport Tracking" : "Transport Completed"
    }

    var trackingStatusSubtitle: String {
        if isTrackingActive {
            return "Vehicle is currently moving towards the nursery."
        } else {
            return "Vehicle has arrived at Little Stars Nursery."
        }
    }

    func advanceRouteProgress() {
        withAnimation(.easeInOut) {
            vehicleStatus = service.updateProgress(from: vehicleStatus)
            isTrackingActive = vehicleStatus.isActive

            if vehicleStatus.isActive {
                statusMessage = "Route progress updated."
            } else {
                statusMessage = "Transport run completed."
            }
        }
    }

    func resetTracking() {
        withAnimation(.easeInOut) {
            vehicleStatus = service.currentVehicleStatus()
            isTrackingActive = vehicleStatus.isActive
            statusMessage = "Transport tracking has been reset."
        }
    }

    func toggleApproximateLocation() {
        showParentApproximateLocation.toggle()
    }
}
