import Foundation
import RealityKit
import SwiftUI

enum ClassroomEntity {
    static func create() -> Entity {
        let root = Entity()
        root.name = "Classroom"

        let table = ModelEntity(
            mesh: .generateBox(width: 0.8, height: 0.12, depth: 0.45),
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

        for x in [-0.45, 0.45] {
            let chair = ModelEntity(
                mesh: .generateBox(width: 0.18, height: 0.22, depth: 0.18),
                materials: [
                    SimpleMaterial(
                        color: .systemYellow,
                        roughness: 0.6,
                        isMetallic: false
                    )
                ]
            )
            chair.position = [Float(x), 0.12, 0.28]
            root.addChild(chair)
        }

        let board = ModelEntity(
            mesh: .generateBox(width: 0.85, height: 0.45, depth: 0.03),
            materials: [
                SimpleMaterial(
                    color: .systemGreen,
                    roughness: 0.6,
                    isMetallic: false
                )
            ]
        )
        board.position = [0, 0.65, -0.42]
        root.addChild(board)

        let panel = NurseryEntity.makeTextPanel(
            text: "Classroom: EYFS Learning Area",
            width: 1.3,
            height: 0.22,
            color: .systemBlue
        )
        panel.position = [0, 1.0, -0.3]
        root.addChild(panel)

        return root
    }

    static func createReadingCorner() -> Entity {
        let root = Entity()
        root.name = "Reading Corner"

        let shelf = ModelEntity(
            mesh: .generateBox(width: 0.9, height: 0.65, depth: 0.16),
            materials: [
                SimpleMaterial(
                    color: .systemBrown,
                    roughness: 0.7,
                    isMetallic: false
                )
            ]
        )
        shelf.position = [0, 0.35, -0.25]
        root.addChild(shelf)

        for index in 0..<5 {
            let book = ModelEntity(
                mesh: .generateBox(width: 0.08, height: 0.24, depth: 0.05),
                materials: [
                    SimpleMaterial(
                        color: UIColor(
                            hue: CGFloat(index) / 5.0,
                            saturation: 0.7,
                            brightness: 0.9,
                            alpha: 1
                        ),
                        roughness: 0.4,
                        isMetallic: false
                    )
                ]
            )
            book.position = [-0.32 + Float(index) * 0.16, 0.42, -0.12]
            root.addChild(book)
        }

        let cushion = ModelEntity(
            mesh: .generateSphere(radius: 0.22),
            materials: [
                SimpleMaterial(
                    color: .systemPurple,
                    roughness: 0.8,
                    isMetallic: false
                )
            ]
        )
        cushion.position = [0, 0.1, 0.25]
        cushion.scale = [1.3, 0.35, 1.0]
        root.addChild(cushion)

        let panel = NurseryEntity.makeTextPanel(
            text: "Reading Corner",
            width: 0.9,
            height: 0.2,
            color: .systemPurple
        )
        panel.position = [0, 0.9, -0.2]
        root.addChild(panel)

        return root
    }
}
