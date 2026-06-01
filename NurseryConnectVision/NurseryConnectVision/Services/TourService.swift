import Foundation

protocol TourServiceProtocol {
    func loadTourLocations() -> [TourLocation]
    func location(for area: NurseryArea) -> TourLocation?
}

final class TourService: TourServiceProtocol {
    private let dataService = MockDataService.shared

    func loadTourLocations() -> [TourLocation] {
        dataService.sampleTourLocations()
    }

    func location(for area: NurseryArea) -> TourLocation? {
        loadTourLocations().first { $0.area == area }
    }
}
