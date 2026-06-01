import Foundation
import RealityKit
import SwiftUI

enum PlaygroundEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Play Area"

        let mat = ModelEntity(
            mesh: .generateBox(width: 1.1, height: 0.04, depth: 0.8),
            materials: [
                SimpleMaterial(
                    color: .systemOrange.withAlphaComponent(0.8),
                    roughness: 0.75,
                    isMetallic: false
                )
            ]
        )
        mat.position = [0, 0.02, 0]
        root.addChild(mat)

        let tunnel = ModelEntity(
            mesh: .generateBox(width: 0.75, height: 0.35, depth: 0.25),
            materials: [
                SimpleMaterial(
                    color: .systemPink,
                    roughness: 0.5,
                    isMetallic: false
                )
            ]
        )
        tunnel.position = [0, 0.25, -0.15]
        root.addChild(tunnel)

        for x in [-0.35, 0, 0.35] {
            let ball = ModelEntity(
                mesh: .generateSphere(radius: 0.09),
                materials: [
                    SimpleMaterial(
                        color: .systemBlue,
                        roughness: 0.4,
                        isMetallic: false
                    )
                ]
            )
            ball.position = [Float(x), 0.14, 0.28]
            root.addChild(ball)
        }

        let panel = NurseryEntity.makeTextPanel(
            text: "Play Area: Social Development",
            width: 1.25,
            height: 0.22,
            color: .systemOrange
        )
        panel.position = [0, 0.85, -0.25]
        root.addChild(panel)

        return root
    }
}
