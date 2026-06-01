import RealityKit
import UIKit

// MARK: - ClassroomEntity

class ClassroomEntity: Entity {

    static func create() -> ClassroomEntity {
        let entity = ClassroomEntity()

        let floor = immersiveMakeBox(width: 4.0, height: 0.08, depth: 4.0, color: .init(red: 0.92, green: 0.88, blue: 0.78, alpha: 1))
        floor.position = [0, -0.04, 0]
        entity.addChild(floor)

        for row in 0..<3 {
            for col in 0..<4 {
                let desk = makeDesk()
                desk.position = [-0.9 + Float(col) * 0.6, 0, -0.6 + Float(row) * 0.6]
                entity.addChild(desk)
            }
        }

        let board = immersiveMakeBox(width: 2.4, height: 1.2, depth: 0.06, color: .init(red: 0.94, green: 0.97, blue: 1.0, alpha: 1))
        board.position = [0, 0.7, -1.95]
        entity.addChild(board)

        let frame = immersiveMakeBox(width: 2.52, height: 1.32, depth: 0.04, color: .init(red: 0.22, green: 0.22, blue: 0.25, alpha: 1))
        frame.position = [0, 0.7, -1.97]
        entity.addChild(frame)

        let shelf = makeLargeShelf()
        shelf.position = [2.0, 0, -1.2]
        entity.addChild(shelf)

        return entity
    }

    private static func makeDesk() -> Entity {
        let g = Entity()
        let top = immersiveMakeBox(width: 0.45, height: 0.06, depth: 0.32, color: .init(red: 0.8, green: 0.62, blue: 0.42, alpha: 1))
        g.addChild(top)
        let leg = immersiveMakeBox(width: 0.03, height: 0.36, depth: 0.03, color: .init(red: 0.5, green: 0.38, blue: 0.25, alpha: 1))
        leg.position = [0, -0.21, 0]
        g.addChild(leg)
        g.position.y = 0.36
        return g
    }

    private static func makeLargeShelf() -> Entity {
        let s = Entity()
        let body = immersiveMakeBox(width: 0.3, height: 1.4, depth: 0.6, color: .init(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        s.addChild(body)
        let bookColors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemCyan]
        for i in 0..<6 {
            let book = immersiveMakeBox(width: 0.28, height: 0.18, depth: 0.08, color: bookColors[i])
            book.position = [0, -0.48 + Float(i) * 0.22, 0.25]
            s.addChild(book)
        }
        s.position.y = 0.7
        return s
    }
}

// MARK: - PlaygroundEntity

class PlaygroundEntity: Entity {

    static func create() -> PlaygroundEntity {
        let entity = PlaygroundEntity()

        let mat = immersiveMakeBox(width: 4.0, height: 0.1, depth: 4.0, color: .init(red: 0.88, green: 0.58, blue: 0.28, alpha: 1))
        mat.position = [0, -0.05, 0]
        entity.addChild(mat)

        let tower = immersiveMakeBox(width: 0.6, height: 1.6, depth: 0.6, color: .init(red: 0.28, green: 0.58, blue: 0.9, alpha: 1))
        tower.position = [1.2, 0.8, -1.0]
        entity.addChild(tower)

        let platform = immersiveMakeBox(width: 0.8, height: 0.08, depth: 0.8, color: .init(red: 0.95, green: 0.38, blue: 0.28, alpha: 1))
        platform.position = [1.2, 1.65, -1.0]
        entity.addChild(platform)

        let slide = immersiveMakeBox(width: 0.45, height: 0.04, depth: 1.3, color: .init(red: 1.0, green: 0.75, blue: 0.1, alpha: 1))
        slide.position = [0.7, 0.95, -0.3]
        slide.transform.rotation = simd_quatf(angle: -.pi / 5, axis: [1, 0, 0])
        entity.addChild(slide)

        let balls: [(Float, Float, UIColor)] = [(-1, 0.5, .systemRed), (0.5, 0.4, .systemBlue), (-0.5, 0.35, .systemGreen)]
        for b in balls {
            let ball = immersiveMakeSphere(radius: 0.18, color: b.2)
            ball.position = [b.0, b.1, 0]
            entity.addChild(ball)
        }

        return entity
    }
}

// MARK: - DiningEntity

class DiningEntity: Entity {
    static func create() -> DiningEntity {
        let entity = DiningEntity()

        let floor = immersiveMakeBox(width: 4.0, height: 0.06, depth: 4.0, color: .init(red: 0.95, green: 0.92, blue: 0.86, alpha: 1))
        floor.position = [0, -0.03, 0]
        entity.addChild(floor)

        for i in 0..<3 {
            let table = immersiveMakeBox(width: 1.0, height: 0.06, depth: 0.7, color: .init(red: 0.8, green: 0.62, blue: 0.42, alpha: 1))
            table.position = [-0.8 + Float(i) * 0.8, 0.5, 0]
            entity.addChild(table)
        }

        return entity
    }
}

// MARK: - GardenEntity

class GardenEntity: Entity {
    static func create() -> GardenEntity {
        let entity = GardenEntity()

        let grass = immersiveMakeBox(width: 5.0, height: 0.06, depth: 5.0, color: .init(red: 0.32, green: 0.62, blue: 0.22, alpha: 1))
        grass.position = [0, -0.03, 0]
        entity.addChild(grass)

        for pos: (Float, Float) in [(-1.5, -1.5), (1.5, -1.5), (-1.5, 1.0)] {
            let trunk = immersiveMakeCylinder(radius: 0.1, height: 0.9, color: .init(red: 0.45, green: 0.3, blue: 0.15, alpha: 1))
            trunk.position = [pos.0, 0.45, pos.1]
            entity.addChild(trunk)
            let canopy = immersiveMakeSphere(radius: 0.55, color: .init(red: 0.22, green: 0.65, blue: 0.25, alpha: 1))
            canopy.position = [pos.0, 1.1, pos.1]
            entity.addChild(canopy)
        }

        return entity
    }
}

// MARK: - NurseryEntity

class NurseryEntity: Entity {
    static func create() -> NurseryEntity {
        let entity = NurseryEntity()

        let classroom = ClassroomEntity.create()
        classroom.position = [-3.5, 0, -3.5]
        entity.addChild(classroom)

        let playground = PlaygroundEntity.create()
        playground.position = [3.5, 0, -3.5]
        entity.addChild(playground)

        let garden = GardenEntity.create()
        garden.position = [0, 0, 3.0]
        entity.addChild(garden)

        return entity
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
        root.addChild(textEntity)

        return root
    }
}

// MARK: - ChildAvatarEntity

class ChildAvatarEntity: Entity {
    static func create(color: UIColor = .systemBlue) -> ChildAvatarEntity {
        let entity = ChildAvatarEntity()

        let body = immersiveMakeCylinder(radius: 0.12, height: 0.5, color: color)
        body.position = [0, 0.25, 0]
        entity.addChild(body)

        let head = immersiveMakeSphere(radius: 0.14, color: .init(red: 0.98, green: 0.85, blue: 0.72, alpha: 1))
        head.position = [0, 0.65, 0]
        entity.addChild(head)

        return entity
    }
}

// MARK: - Immersive-scale helpers

private func immersiveMakeBox(width: Float, height: Float, depth: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateBox(width: width, height: height, depth: depth, cornerRadius: 0.02)
    var mat = PhysicallyBasedMaterial()
    mat.baseColor = .init(tint: color)
    mat.roughness = .init(floatLiteral: 0.65)
    mat.metallic = .init(floatLiteral: 0.05)
    return ModelEntity(mesh: mesh, materials: [mat])
}

private func immersiveMakeSphere(radius: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateSphere(radius: radius)
    var mat = PhysicallyBasedMaterial()
    mat.baseColor = .init(tint: color)
    mat.roughness = .init(floatLiteral: 0.4)
    return ModelEntity(mesh: mesh, materials: [mat])
}

private func immersiveMakeCylinder(radius: Float, height: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateCylinder(height: height, radius: radius)
    var mat = PhysicallyBasedMaterial()
    mat.baseColor = .init(tint: color)
    mat.roughness = .init(floatLiteral: 0.5)
    return ModelEntity(mesh: mesh, materials: [mat])
}
