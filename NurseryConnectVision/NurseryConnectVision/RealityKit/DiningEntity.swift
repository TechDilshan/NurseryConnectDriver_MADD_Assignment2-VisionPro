import Foundation
import RealityKit
import SwiftUI

enum DiningEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Dining Area"

        let table = ModelEntity(
            mesh: .generateBox(width: 0.95, height: 0.12, depth: 0.55),
            materials: [
                SimpleMaterial(
                    color: .systemBrown,
                    roughness: 0.7,
                    isMetallic: false
                )
            ]
        )
        table.position = [0, 0.2, 0]
        root.addChild(table)

        for x in [-0.25, 0.25] {
            let plate = ModelEntity(
                mesh: .generateCylinder(height: 0.02, radius: 0.12),
                materials: [
                    SimpleMaterial(
                        color: .white,
                        roughness: 0.3,
                        isMetallic: false
                    )
                ]
            )
            plate.position = [Float(x), 0.28, 0]
            root.addChild(plate)

            let food = ModelEntity(
                mesh: .generateSphere(radius: 0.055),
                materials: [
                    SimpleMaterial(
                        color: .systemGreen,
                        roughness: 0.4,
                        isMetallic: false
                    )
                ]
            )
            food.position = [Float(x), 0.32, 0]
            root.addChild(food)
        }

        let allergenPanel = NurseryEntity.makeTextPanel(
            text: "Allergen-aware Meal Area",
            width: 1.2,
            height: 0.22,
            color: .systemGreen
        )
        allergenPanel.position = [0, 0.85, -0.25]
        root.addChild(allergenPanel)

        return root
    }
}
