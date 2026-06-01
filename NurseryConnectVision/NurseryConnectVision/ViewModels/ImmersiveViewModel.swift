import Foundation
import SwiftUI
import RealityKit

@MainActor
final class ImmersiveViewModel: ObservableObject {

    @Published var selectedArea: NurseryArea = .classroom
    @Published var isImmersiveSpaceOpen: Bool = false
    @Published var statusMessage: String = "Immersive nursery space is ready."
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
        withAnimation(.easeInOut) {
            selectedArea = area
            statusMessage = "\(area.title) selected in immersive space."
        }
    }

    func markImmersiveSpaceOpened() {
        isImmersiveSpaceOpen = true
        statusMessage = "Immersive nursery tour is active."
    }

    func markImmersiveSpaceClosed() {
        isImmersiveSpaceOpen = false
        statusMessage = "Immersive nursery tour is closed."
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
