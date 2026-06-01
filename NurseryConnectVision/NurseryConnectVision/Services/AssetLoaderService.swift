import Foundation
import RealityKit

protocol AssetLoaderServiceProtocol {
    func loadEntity(named name: String) async -> Entity
}

final class AssetLoaderService: AssetLoaderServiceProtocol {
    func loadEntity(named name: String) async -> Entity {
        do {
            let entity = try await Entity(named: name)
            return entity
        } catch {
            return fallbackEntity(name: name)
        }
    }

    private func fallbackEntity(name: String) -> Entity {
        let mesh = MeshResource.generateBox(size: 0.35)
        let material = SimpleMaterial(
            color: .systemBlue,
            roughness: 0.35,
            isMetallic: false
        )

        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.name = name
        return entity
    }
}
