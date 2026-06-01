import Foundation
import RealityKit
import SwiftUI

enum NurseryEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Nursery Root"

        let floor = ModelEntity(
            mesh: .generateBox(width: 2.8, height: 0.04, depth: 2.0),
            materials: [
                SimpleMaterial(
                    color: .lightGray.withAlphaComponent(0.45),
                    roughness: 0.8,
                    isMetallic: false
                )
            ]
        )
        floor.position = [0, -0.05, -1.45]
        root.addChild(floor)

        let backWall = ModelEntity(
            mesh: .generateBox(width: 2.8, height: 1.2, depth: 0.04),
            materials: [
                SimpleMaterial(
                    color: .systemTeal.withAlphaComponent(0.25),
                    roughness: 0.7,
                    isMetallic: false
                )
            ]
        )
        backWall.position = [0, 0.55, -2.45]
        root.addChild(backWall)

        let leftWall = ModelEntity(
            mesh: .generateBox(width: 0.04, height: 1.2, depth: 2.0),
            materials: [
                SimpleMaterial(
                    color: .systemBlue.withAlphaComponent(0.15),
                    roughness: 0.7,
                    isMetallic: false
                )
            ]
        )
        leftWall.position = [-1.4, 0.55, -1.45]
        root.addChild(leftWall)

        let rightWall = leftWall.clone(recursive: true)
        rightWall.position = [1.4, 0.55, -1.45]
        root.addChild(rightWall)

        let titlePanel = makeTextPanel(
            text: "NurseryConnect Vision",
            width: 1.4,
            height: 0.22,
            color: .systemBlue
        )
        titlePanel.position = [0, 1.25, -2.35]
        root.addChild(titlePanel)

        return root
    }

    static func createSafetyDesk() -> Entity {
        let root = Entity()
        root.name = "Safety Desk"

        let desk = ModelEntity(
            mesh: .generateBox(width: 0.9, height: 0.22, depth: 0.42),
            materials: [
                SimpleMaterial(
                    color: .systemRed.withAlphaComponent(0.7),
                    roughness: 0.55,
                    isMetallic: false
                )
            ]
        )
        desk.position = [0, 0.1, 0]
        root.addChild(desk)

        let shield = ModelEntity(
            mesh: .generateSphere(radius: 0.16),
            materials: [
                SimpleMaterial(
                    color: .systemRed,
                    roughness: 0.4,
                    isMetallic: false
                )
            ]
        )
        shield.position = [0, 0.38, 0]
        root.addChild(shield)

        let panel = makeTextPanel(
            text: "Safety & Safeguarding",
            width: 1.1,
            height: 0.22,
            color: .systemRed
        )
        panel.position = [0, 0.7, 0]
        root.addChild(panel)

        return root
    }

    static func makeTextPanel(
        text: String,
        width: Float,
        height: Float,
        color: UIColor
    ) -> Entity {
        let root = Entity()

        let panel = ModelEntity(
            mesh: .generateBox(width: width, height: height, depth: 0.02),
            materials: [
                SimpleMaterial(
                    color: color.withAlphaComponent(0.25),
                    roughness: 0.4,
                    isMetallic: false
                )
            ]
        )
        root.addChild(panel)

        let textMesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.004,
            font: .systemFont(ofSize: 0.035, weight: .bold),
            containerFrame: CGRect(x: -CGFloat(width) / 2, y: -0.025, width: CGFloat(width), height: CGFloat(height)),
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )

        let textEntity = ModelEntity(
            mesh: textMesh,
            materials: [
                SimpleMaterial(
                    color: .white,
                    roughness: 0.4,
                    isMetallic: false
                )
            ]
        )
        textEntity.position = [-width / 2 + 0.05, -0.03, 0.02]
        textEntity.scale = [1, 1, 1]
        root.addChild(textEntity)

        return root
    }
}
