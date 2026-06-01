import Foundation
import SwiftUI

@MainActor
final class NurseryTourViewModel: ObservableObject {

    @Published var tourLocations: [TourLocation]
    @Published var selectedArea: NurseryArea = .classroom
    @Published var selectedLocation: TourLocation?
    @Published var isShowingTourInfo: Bool = true

    private let service: TourServiceProtocol

    init(service: TourServiceProtocol = TourService()) {
        self.service = service
        self.tourLocations = service.loadTourLocations()
        self.selectedLocation = service.location(for: .classroom)
    }

    var selectedAreaTitle: String {
        selectedArea.title
    }

    var selectedAreaDescription: String {
        selectedArea.description
    }

    var selectedAssetName: String {
        selectedLocation?.assetName ?? selectedArea.assetName
    }

    func selectArea(_ area: NurseryArea) {
        withAnimation(.easeInOut) {
            selectedArea = area
            selectedLocation = service.location(for: area)
            isShowingTourInfo = true
        }
    }

    func toggleInfoPanel() {
        withAnimation(.easeInOut) {
            isShowingTourInfo.toggle()
        }
    }

    func nextArea() {
        let areas = NurseryArea.allCases
        guard let currentIndex = areas.firstIndex(of: selectedArea) else {
            selectArea(.classroom)
            return
        }

        let nextIndex = (currentIndex + 1) % areas.count
        selectArea(areas[nextIndex])
    }

    func previousArea() {
        let areas = NurseryArea.allCases
        guard let currentIndex = areas.firstIndex(of: selectedArea) else {
            selectArea(.classroom)
            return
        }

        let previousIndex = (currentIndex - 1 + areas.count) % areas.count
        selectArea(areas[previousIndex])
    }
}
