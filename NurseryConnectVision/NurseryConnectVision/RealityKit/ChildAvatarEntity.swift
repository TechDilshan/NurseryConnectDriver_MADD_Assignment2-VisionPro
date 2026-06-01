import Foundation
import RealityKit
import SwiftUI

enum ChildAvatarEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Child Avatar"

        let body = ModelEntity(
            mesh: .generateCylinder(height: 0.38, radius: 0.09),
            materials: [
                SimpleMaterial(
                    color: .systemBlue,
                    roughness: 0.55,
                    isMetallic: false
                )
            ]
        )
        body.position = [0, 0.25, 0]
        root.addChild(body)

        let head = ModelEntity(
            mesh: .generateSphere(radius: 0.11),
            materials: [
                SimpleMaterial(
                    color: .systemYellow,
                    roughness: 0.45,
                    isMetallic: false
                )
            ]
        )
        head.position = [0, 0.52, 0]
        root.addChild(head)

        let badge = NurseryEntity.makeTextPanel(
            text: "Parent View",
            width: 0.55,
            height: 0.16,
            color: .systemBlue
        )
        badge.position = [0, 0.75, 0]
        root.addChild(badge)

        return root
    }
}
