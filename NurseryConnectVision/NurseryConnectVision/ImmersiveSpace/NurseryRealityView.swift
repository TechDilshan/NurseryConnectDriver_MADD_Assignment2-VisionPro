import SwiftUI
import RealityKit

struct NurseryRealityView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        RealityView { content in
            let root = Entity()
            root.name = "BeautifulNurseryRoot"
            root.position = [0, 1.1, -2.2]
            root.scale = [0.85, 0.85, 0.85]

            root.addChild(createBeautifulNurseryScene(selectedArea: immersiveViewModel.selectedArea))
            content.add(root)

        } update: { content in
            guard let root = content.entities.first else { return }

            root.children.removeAll()
            root.addChild(createBeautifulNurseryScene(selectedArea: immersiveViewModel.selectedArea))
        }
    }

    private func createBeautifulNurseryScene(selectedArea: NurseryArea) -> Entity {
        let scene = Entity()
        scene.name = "BeautifulMiniNursery"

        let base = ModelEntity(
            mesh: .generateBox(width: 2.4, height: 0.05, depth: 1.8),
            materials: [
                SimpleMaterial(
                    color: .systemMint.withAlphaComponent(0.45),
                    roughness: 0.75,
                    isMetallic: false
                )
            ]
        )
        base.position = [0, 0, 0]
        scene.addChild(base)

        addRoom(
            to: scene,
            title: "Classroom",
            color: .systemBlue,
            position: [-0.65, 0.08, -0.45],
            selected: selectedArea == .classroom || selectedArea == .readingCorner
        )

        addRoom(
            to: scene,
            title: "Play Area",
            color: .systemOrange,
            position: [0.65, 0.08, -0.45],
            selected: selectedArea == .playArea
        )

        addRoom(
            to: scene,
            title: "Dining",
            color: .systemGreen,
            position: [-0.65, 0.08, 0.45],
            selected: selectedArea == .diningArea
        )

        addRoom(
            to: scene,
            title: "Garden",
            color: .systemPurple,
            position: [0.65, 0.08, 0.45],
            selected: selectedArea == .outdoorGarden
        )

        let child = ChildAvatarEntity.create()
        child.position = [0, 0.08, 0]
        child.scale = [0.55, 0.55, 0.55]
        scene.addChild(child)

        let title = NurseryEntity.makeTextPanel(
            text: "NurseryConnect Vision",
            width: 1.25,
            height: 0.18,
            color: .systemBlue
        )
        title.position = [0, 0.75, -0.75]
        scene.addChild(title)

        return scene
    }

    private func addRoom(
        to scene: Entity,
        title: String,
        color: UIColor,
        position: SIMD3<Float>,
        selected: Bool
    ) {
        let room = Entity()
        room.position = position

        let floor = ModelEntity(
            mesh: .generateBox(width: 0.72, height: 0.04, depth: 0.52),
            materials: [
                SimpleMaterial(
                    color: color.withAlphaComponent(selected ? 0.75 : 0.38),
                    roughness: 0.65,
                    isMetallic: false
                )
            ]
        )
        floor.position = [0, 0, 0]
        room.addChild(floor)

        let backWall = ModelEntity(
            mesh: .generateBox(width: 0.72, height: 0.38, depth: 0.035),
            materials: [
                SimpleMaterial(
                    color: color.withAlphaComponent(0.22),
                    roughness: 0.65,
                    isMetallic: false
                )
            ]
        )
        backWall.position = [0, 0.22, -0.25]
        room.addChild(backWall)

        let table = ModelEntity(
            mesh: .generateBox(width: 0.28, height: 0.08, depth: 0.18),
            materials: [
                SimpleMaterial(
                    color: .systemBrown,
                    roughness: 0.7,
                    isMetallic: false
                )
            ]
        )
        table.position = [0, 0.09, 0]
        room.addChild(table)

        let decoration = ModelEntity(
            mesh: .generateSphere(radius: selected ? 0.08 : 0.055),
            materials: [
                SimpleMaterial(
                    color: .systemYellow,
                    roughness: 0.5,
                    isMetallic: false
                )
            ]
        )
        decoration.position = [0.22, 0.18, 0.1]
        room.addChild(decoration)

        let label = NurseryEntity.makeTextPanel(
            text: title,
            width: 0.55,
            height: 0.12,
            color: color
        )
        label.position = [0, 0.48, -0.1]
        room.addChild(label)

        if selected {
            let marker = ModelEntity(
                mesh: .generateSphere(radius: 0.055),
                materials: [
                    SimpleMaterial(
                        color: .systemYellow,
                        roughness: 0.35,
                        isMetallic: false
                    )
                ]
            )
            marker.position = [0, 0.35, 0.18]
            room.addChild(marker)
        }

        scene.addChild(room)
    }
}
