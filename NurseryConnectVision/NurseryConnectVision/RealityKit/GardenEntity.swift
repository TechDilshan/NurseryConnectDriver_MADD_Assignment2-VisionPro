import Foundation
import RealityKit
import SwiftUI

enum GardenEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Outdoor Garden"

        let grass = ModelEntity(
            mesh: .generateBox(width: 1.4, height: 0.04, depth: 1.0),
            materials: [
                SimpleMaterial(
                    color: .systemGreen,
                    roughness: 0.8,
                    isMetallic: false
                )
            ]
        )
        grass.position = [0, 0.02, 0]
        root.addChild(grass)

        for x in [-0.45, 0.45] {
            let trunk = ModelEntity(
                mesh: .generateCylinder(height: 0.35, radius: 0.04),
                materials: [
                    SimpleMaterial(
                        color: .systemBrown,
                        roughness: 0.65,
                        isMetallic: false
                    )
                ]
            )
            trunk.position = [Float(x), 0.22, -0.25]
            root.addChild(trunk)

            let leaves = ModelEntity(
                mesh: .generateSphere(radius: 0.18),
                materials: [
                    SimpleMaterial(
                        color: .systemGreen,
                        roughness: 0.7,
                        isMetallic: false
                    )
                ]
            )
            leaves.position = [Float(x), 0.48, -0.25]
            root.addChild(leaves)
        }

        let panel = NurseryEntity.makeTextPanel(
            text: "Outdoor Garden: Supervised Play",
            width: 1.3,
            height: 0.22,
            color: .systemGreen
        )
        panel.position = [0, 0.9, -0.35]
        root.addChild(panel)

        return root
    }
}
