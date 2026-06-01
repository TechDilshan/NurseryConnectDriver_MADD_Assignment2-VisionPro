import Foundation
import SwiftUI
import RealityKit

@MainActor
final class ImmersiveViewModel: ObservableObject {

    @Published var selectedArea: NurseryArea = .classroom
    @Published var isImmersiveSpaceOpen: Bool = false
    @Published var isImmersiveSessionActive: Bool = false
    @Published var statusMessage: String = "Tap Start Immersive Mode to enter the spatial tour."
    @Published var loadedEntities: [String: Entity] = [:]

    private let assetLoaderService: AssetLoaderServiceProtocol

    init(assetLoaderService: AssetLoaderServiceProtocol = AssetLoaderService()) {
        self.assetLoaderService = assetLoaderService
    }

    var selectedAreaTitle: String {
        selectedArea.title
    }

    var selectedAreaDescription: String {
        selectedArea.description
    }

    func selectArea(_ area: NurseryArea) {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedArea = area
            if isImmersiveSpaceOpen {
                statusMessage = "Viewing \(area.title) in immersive space."
            }
        }
    }

    func prepareImmersiveStart(area: NurseryArea) {
        selectArea(area)
        isImmersiveSessionActive = true
        statusMessage = "Opening immersive space…"
    }

    func markImmersiveSpaceOpened() {
        isImmersiveSpaceOpen = true
        isImmersiveSessionActive = true
        statusMessage = "Immersive tour active — use the top panel to change areas or Stop to exit."
    }

    func markImmersiveOpenCancelled() {
        isImmersiveSessionActive = false
        statusMessage = "Immersive opening was cancelled."
    }

    func markImmersiveOpenFailed() {
        isImmersiveSessionActive = false
        statusMessage = "Could not open immersive space. Try again."
    }

    func markImmersiveSpaceClosed() {
        isImmersiveSpaceOpen = false
        isImmersiveSessionActive = false
        statusMessage = "Immersive mode stopped. Tap Start to enter again."
    }

    func loadEntity(for area: NurseryArea) async -> Entity {
        if let entity = loadedEntities[area.assetName] {
            return entity.clone(recursive: true)
        }

        let entity = await assetLoaderService.loadEntity(named: area.assetName)
        loadedEntities[area.assetName] = entity
        return entity.clone(recursive: true)
    }

    func nextArea() {
        let areas = NurseryArea.allCases
        guard let currentIndex = areas.firstIndex(of: selectedArea) else {
            selectArea(.classroom)
            return
        }
        selectArea(areas[(currentIndex + 1) % areas.count])
    }

    func previousArea() {
        let areas = NurseryArea.allCases
        guard let currentIndex = areas.firstIndex(of: selectedArea) else {
            selectArea(.classroom)
            return
        }
        selectArea(areas[(currentIndex - 1 + areas.count) % areas.count])
    }
}
