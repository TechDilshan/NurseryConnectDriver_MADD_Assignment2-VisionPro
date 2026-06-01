import RealityKit
import SwiftUI

// MARK: - Scene factory (window preview + immersive)

enum NurseryAreaSceneFactory {
    static func buildPreview(for area: NurseryArea) -> Entity {
        let scene: Entity
        switch area {
        case .classroom:     scene = ClassroomSceneEntity.buildScene()
        case .playArea:      scene = PlayAreaSceneEntity.buildScene()
        case .diningArea:    scene = DiningSceneEntity.buildScene()
        case .outdoorGarden: scene = OutdoorSceneEntity.buildScene()
        case .readingCorner: scene = ReadingCornerSceneEntity.buildScene()
        case .safetyDesk:    scene = SafetyDeskSceneEntity.buildScene()
        }

        scene.position = [0, 0.05, 0]
        scene.orientation = simd_quatf(angle: .pi / 6, axis: [0, 1, 0])
        return scene
    }

    static func buildImmersive(for area: NurseryArea) -> Entity {
        let scene = buildPreview(for: area)
        scene.scale = [2.2, 2.2, 2.2]
        scene.position = [0, 0.9, -1.6]
        return scene
    }
}

// MARK: - Window card 3D preview

struct AreaPreviewRealityView: View {
    let area: NurseryArea

    var body: some View {
        RealityView { content in
            content.add(NurseryAreaSceneFactory.buildPreview(for: area))
        } update: { content in
            content.entities.removeAll()
            content.add(NurseryAreaSceneFactory.buildPreview(for: area))
        }
        .id(area)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
