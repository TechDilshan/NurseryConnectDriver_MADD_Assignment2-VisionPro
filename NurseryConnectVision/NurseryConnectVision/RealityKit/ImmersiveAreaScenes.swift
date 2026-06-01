import RealityKit
import UIKit

// MARK: - Full-scale immersive scenes

enum ImmersiveAreaScenes {
    static func build(for area: NurseryArea) -> Entity {
        switch area {
        case .classroom:     return ImmersiveClassroomScene.build()
        case .playArea:      return ImmersivePlayAreaScene.build()
        case .diningArea:    return ImmersiveDiningScene.build()
        case .outdoorGarden: return ImmersiveGardenScene.build()
        case .readingCorner: return ImmersiveReadingCornerScene.build()
        case .safetyDesk:    return ImmersiveSafetyDeskScene.build()
        }
    }
}

// MARK: - Classroom

enum ImmersiveClassroomScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersiveClassroom"

        let floor = makeBox(width: 12, height: 0.08, depth: 12, color: UIColor(red: 0.93, green: 0.9, blue: 0.82, alpha: 1))
        floor.position = [0, 0, 0]
        root.addChild(floor)

        ImmersiveSceneBuilders.addWall(to: root, width: 12, height: 2.8, at: [0, 1.4, -6])
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.8, at: [-6, 1.4, 0], depth: 12)
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.8, at: [6, 1.4, 0], depth: 12)

        let board = makeBox(width: 5, height: 1.5, depth: 0.06, color: UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1))
        board.position = [0, 1.55, -5.85]
        root.addChild(board)
        let frame = makeBox(width: 5.2, height: 1.65, depth: 0.04, color: .darkGray)
        frame.position = [0, 1.55, -5.88]
        root.addChild(frame)

        let teacherDesk = makeBox(width: 1.6, height: 0.08, depth: 0.75, color: UIColor(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        teacherDesk.position = [0, 0.5, -4.5]
        root.addChild(teacherDesk)
        let teacherChair = makeBox(width: 0.5, height: 0.05, depth: 0.5, color: .systemBlue)
        teacherChair.position = [0, 0.28, -3.7]
        root.addChild(teacherChair)

        for row in 0..<4 {
            for col in 0..<5 {
                let desk = studentDeskSet()
                desk.position = [-3 + Float(col) * 1.45, 0, -2 + Float(row) * 1.35]
                root.addChild(desk)
            }
        }

        let shelf = ImmersiveSceneBuilders.bookRack(width: 1.2, shelves: 4)
        shelf.position = [5, 0, -3]
        shelf.orientation = simd_quatf(angle: -.pi / 2, axis: [0, 1, 0])
        root.addChild(shelf)

        let globe = makeSphere(radius: 0.18, color: UIColor(red: 0.25, green: 0.65, blue: 0.9, alpha: 1))
        globe.position = [0.4, 0.65, -4.5]
        root.addChild(globe)

        for x: Float in [-4, 4] {
            let light = makeBox(width: 0.4, height: 0.08, depth: 0.4, color: .white)
            light.position = [x, 2.5, 0]
            root.addChild(light)
        }

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-2.8, 0, -0.8], isBoy: true, yaw: 0.3),
            .init(position: [-1.2, 0, -0.8], isBoy: false, yaw: -0.2),
            .init(position: [0.5, 0, -2.2], isBoy: true),
            .init(position: [2.2, 0, -2.2], isBoy: false),
            .init(position: [-2.8, 0, 0.6], isBoy: false, yaw: 0.5),
            .init(position: [-1.2, 0, 0.6], isBoy: true),
            .init(position: [0.5, 0, 1.0], isBoy: false),
            .init(position: [2.2, 0, 1.0], isBoy: true, yaw: -0.4),
            .init(position: [3.8, 0, -0.5], isBoy: true),
            .init(position: [3.8, 0, 1.2], isBoy: false)
        ])

        return root
    }

    private static func studentDeskSet() -> Entity {
        let g = Entity()
        let top = makeBox(width: 0.75, height: 0.05, depth: 0.52, color: UIColor(red: 0.8, green: 0.62, blue: 0.42, alpha: 1))
        top.position = [0, 0.38, 0]
        g.addChild(top)
        for x: Float in [-0.28, 0.28] {
            let leg = makeBox(width: 0.04, height: 0.35, depth: 0.04, color: .brown)
            leg.position = [x, 0.18, 0]
            g.addChild(leg)
        }
        let chair = makeBox(width: 0.42, height: 0.04, depth: 0.42, color: .systemTeal)
        chair.position = [0, 0.22, 0.45]
        g.addChild(chair)
        return g
    }
}

// MARK: - Play Area

enum ImmersivePlayAreaScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersivePlayArea"

        let grass = makeBox(width: 18, height: 0.1, depth: 16, color: UIColor(red: 0.3, green: 0.68, blue: 0.26, alpha: 1))
        grass.position = [0, 0, 0]
        root.addChild(grass)

        // Cricket pitch
        let pitch = makeBox(width: 2, height: 0.02, depth: 9, color: UIColor(red: 0.85, green: 0.78, blue: 0.55, alpha: 1))
        pitch.position = [-6, 0.08, -1]
        root.addChild(pitch)
        for z: Float in [-4, 4] {
            let stump = makeBox(width: 0.06, height: 0.55, depth: 0.06, color: .white)
            stump.position = [-6, 0.32, z]
            root.addChild(stump)
        }

        // Basketball
        let bballFloor = makeBox(width: 5.5, height: 0.02, depth: 5, color: UIColor(red: 0.9, green: 0.45, blue: 0.15, alpha: 1))
        bballFloor.position = [2, 0.08, -5]
        root.addChild(bballFloor)
        let hoopPole = makeCylinder(radius: 0.07, height: 2.4, color: .darkGray)
        hoopPole.position = [4.5, 1.25, -7]
        root.addChild(hoopPole)
        let backboard = makeBox(width: 0.08, height: 1, depth: 1.4, color: .white)
        backboard.position = [4.65, 2.2, -7]
        root.addChild(backboard)
        let rim = makeCylinder(radius: 0.24, height: 0.03, color: .systemOrange)
        rim.position = [4.5, 2.05, -7]
        rim.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
        root.addChild(rim)

        // Badminton
        let badminton = makeBox(width: 4, height: 0.02, depth: 7, color: UIColor(red: 0.15, green: 0.35, blue: 0.75, alpha: 1))
        badminton.position = [-6, 0.08, 4]
        root.addChild(badminton)
        let net = makeBox(width: 0.04, height: 1.3, depth: 3.5, color: .white)
        net.position = [-6, 0.7, 4]
        root.addChild(net)

        // Swimming pool + poster, gym, netball (enhanced complexes)
        root.addChild(ImmersiveSceneBuilders.swimmingPoolComplex(at: [5.5, 0, 4]))
        root.addChild(ImmersiveSceneBuilders.gymComplex(at: [-5, 0, 3.5]))
        root.addChild(ImmersiveSceneBuilders.netballComplex(at: [5, 0, -4]))

        let playSign = ImmersiveSceneBuilders.signPanel(
            text: "Nursery Sports Complex",
            width: 2.6,
            height: 0.55,
            color: UIColor(red: 0.15, green: 0.55, blue: 0.25, alpha: 1)
        )
        playSign.position = [0, 2.2, -7.5]
        root.addChild(playSign)

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-6.5, 0, -2], isBoy: true, yaw: 0.4),
            .init(position: [-5.2, 0, 0.5], isBoy: false),
            .init(position: [-6, 0, 4.5], isBoy: true),
            .init(position: [3.5, 0, -5.5], isBoy: false, yaw: -0.5),
            .init(position: [5.5, 0, 3.5], isBoy: true),
            .init(position: [4, 0, 5], isBoy: false),
            .init(position: [-4, 0, 3], isBoy: true, yaw: 0.2),
            .init(position: [6, 0, -3], isBoy: false)
        ])

        return root
    }
}

// MARK: - Dining

enum ImmersiveDiningScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersiveDining"

        let floor = makeBox(width: 12, height: 0.08, depth: 12, color: UIColor(red: 0.95, green: 0.92, blue: 0.86, alpha: 1))
        floor.position = [0, 0, 0]
        root.addChild(floor)

        ImmersiveSceneBuilders.addWall(to: root, width: 12, height: 2.6, at: [0, 1.3, -6])
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.6, at: [-6, 1.3, 0], depth: 12)

        for row in 0..<2 {
            for col in 0..<3 {
                let table = ImmersiveSceneBuilders.lunchTableWithPlaceSettings()
                table.position = [-2.5 + Float(col) * 2.5, 0, -1.5 + Float(row) * 2.2]
                root.addChild(table)
            }
        }

        root.addChild(ImmersiveSceneBuilders.canteenCounter(at: [0, 0, -4.8]))
        root.addChild(ImmersiveSceneBuilders.washBasinStation(at: [4, 0, 4.5]))

        let bin = makeCylinder(radius: 0.22, height: 0.55, color: .systemGreen)
        bin.position = [-5, 0.32, 5]
        root.addChild(bin)

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-2.5, 0, -0.5], isBoy: true),
            .init(position: [-2.5, 0, 0.8], isBoy: false),
            .init(position: [0, 0, -0.5], isBoy: false, yaw: 0.3),
            .init(position: [0, 0, 0.8], isBoy: true),
            .init(position: [2.5, 0, -0.5], isBoy: true),
            .init(position: [2.5, 0, 0.8], isBoy: false),
            .init(position: [-4, 0, 2.5], isBoy: true, yaw: -0.6),
            .init(position: [3.5, 0, 3], isBoy: false)
        ])

        return root
    }
}

// MARK: - Garden

enum ImmersiveGardenScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersiveGarden"

        let grass = makeBox(width: 18, height: 0.08, depth: 18, color: UIColor(red: 0.26, green: 0.6, blue: 0.22, alpha: 1))
        grass.position = [0, 0, 0]
        root.addChild(grass)

        // Roads — cross through garden
        root.addChild(ImmersiveSceneBuilders.roadSegment(width: 2.2, depth: 16, at: [0, 0.1, 0]))
        root.addChild(ImmersiveSceneBuilders.roadSegment(width: 16, depth: 2.2, at: [0, 0.1, 0], rotation: .pi / 2))

        // Jogging track (outer ring)
        for i in 0..<32 {
            let angle = Float(i) / 32 * .pi * 2
            let r: Float = 7.5
            let track = makeBox(width: 1.0, height: 0.03, depth: 0.55, color: UIColor(red: 0.72, green: 0.68, blue: 0.62, alpha: 1))
            track.position = [cos(angle) * r, 0.1, sin(angle) * r]
            track.orientation = simd_quatf(angle: angle, axis: [0, 1, 0])
            root.addChild(track)
        }

        // Central pond
        root.addChild(ImmersiveSceneBuilders.pond(at: [0, 0, 0], radius: 2.2))

        // Flower areas
        let bedPositions: [SIMD3<Float>] = [
            [-5, 0, -5], [5, 0, -5], [-5, 0, 5], [5, 0, 5],
            [-3, 0, 0], [3, 0, 0]
        ]
        for (i, pos) in bedPositions.enumerated() {
            root.addChild(ImmersiveSceneBuilders.flowerBed(at: pos, width: i < 4 ? 2.4 : 2.0, depth: 1.6))
        }

        // Trees around perimeter
        for i in 0..<14 {
            let angle = Float(i) / 14 * .pi * 2
            let r: Float = 8.2
            let tree = ImmersiveSceneBuilders.realisticTree(variant: i)
            tree.position = [cos(angle) * r, 0, sin(angle) * r]
            root.addChild(tree)
        }

        let gardenSign = ImmersiveSceneBuilders.signPanel(
            text: "Outdoor Garden",
            width: 1.8,
            height: 0.45,
            color: UIColor(red: 0.12, green: 0.48, blue: 0.22, alpha: 1)
        )
        gardenSign.position = [0, 1.6, -8]
        root.addChild(gardenSign)

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-1.5, 0, 1.5], isBoy: true),
            .init(position: [1.5, 0, 1.5], isBoy: false),
            .init(position: [-1.5, 0, -1.5], isBoy: false, yaw: 0.8),
            .init(position: [1.5, 0, -1.5], isBoy: true, yaw: -0.8),
            .init(position: [3.5, 0, 0], isBoy: true),
            .init(position: [-3.5, 0, 0], isBoy: false),
            .init(position: [0, 0, 3.5], isBoy: true, yaw: 3.14)
        ])

        return root
    }
}

// MARK: - Reading Corner (Library)

enum ImmersiveReadingCornerScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersiveLibrary"

        let floor = makeBox(width: 12, height: 0.08, depth: 12, color: UIColor(red: 0.68, green: 0.48, blue: 0.3, alpha: 1))
        floor.position = [0, 0, 0]
        root.addChild(floor)

        ImmersiveSceneBuilders.addWall(to: root, width: 12, height: 2.8, at: [0, 1.4, -6])
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.8, at: [-6, 1.4, 0], depth: 12)
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.8, at: [6, 1.4, 0], depth: 12)

        // Book racks along walls
        let backRack = ImmersiveSceneBuilders.bookRack(width: 5.5, shelves: 6)
        backRack.position = [0, 0, -5.5]
        root.addChild(backRack)

        for z: Float in [-3, 0, 3] {
            let sideRack = ImmersiveSceneBuilders.bookRack(width: 2.8, shelves: 5)
            sideRack.position = [-5.5, 0, z]
            sideRack.orientation = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
            root.addChild(sideRack)
        }

        let tallRack = ImmersiveSceneBuilders.bookRack(width: 3.5, shelves: 7)
        tallRack.position = [5.2, 0, -2]
        tallRack.orientation = simd_quatf(angle: -.pi / 2, axis: [0, 1, 0])
        root.addChild(tallRack)

        // Reading tables with lamps
        let tablePositions: [SIMD3<Float>] = [
            [-2, 0, 2], [2, 0, 2], [-2, 0, 4.5], [2, 0, 4.5]
        ]
        for pos in tablePositions {
            let table = ImmersiveSceneBuilders.readingTableWithLamp()
            table.position = pos
            root.addChild(table)
        }

        // Circulation desk
        let desk = makeBox(width: 2.2, height: 0.9, depth: 0.8, color: UIColor(red: 0.45, green: 0.32, blue: 0.2, alpha: 1))
        desk.position = [0, 0.5, 5]
        root.addChild(desk)
        let deskTop = makeBox(width: 2.3, height: 0.05, depth: 0.85, color: .lightGray)
        deskTop.position = [0, 0.98, 5]
        root.addChild(deskTop)
        let computer = makeBox(width: 0.4, height: 0.3, depth: 0.04, color: .black)
        computer.position = [-0.4, 1.1, 5]
        root.addChild(computer)

        let rug = makeBox(width: 4, height: 0.04, depth: 3, color: UIColor(red: 0.45, green: 0.28, blue: 0.55, alpha: 1))
        rug.position = [0, 0.1, 3]
        root.addChild(rug)

        let librarySign = ImmersiveSceneBuilders.signPanel(
            text: "Nursery Library",
            width: 2.0,
            height: 0.5,
            color: UIColor(red: 0.35, green: 0.22, blue: 0.55, alpha: 1)
        )
        librarySign.position = [0, 2.3, -5.7]
        root.addChild(librarySign)

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-2.2, 0, 2.6], isBoy: true, yaw: 0.2),
            .init(position: [2.2, 0, 2.6], isBoy: false, yaw: -0.2),
            .init(position: [-2.2, 0, 4.8], isBoy: false),
            .init(position: [2.2, 0, 4.8], isBoy: true),
            .init(position: [0, 0, 3.2], isBoy: true, yaw: 3.14),
            .init(position: [-4, 0, 0], isBoy: false, yaw: 0.6)
        ])

        return root
    }
}

// MARK: - Safety Desk

enum ImmersiveSafetyDeskScene {
    static func build() -> Entity {
        let root = Entity()
        root.name = "ImmersiveSafetyDesk"

        let floor = makeBox(width: 14, height: 0.08, depth: 12, color: UIColor(white: 0.82, alpha: 1))
        floor.position = [0, 0, 0]
        root.addChild(floor)

        ImmersiveSceneBuilders.addWall(to: root, width: 14, height: 2.6, at: [0, 1.3, -6])
        ImmersiveSceneBuilders.addWall(to: root, width: 0.12, height: 2.6, at: [-7, 1.3, 0], depth: 12)

        // Medical bay — hospital beds + safety equipment
        root.addChild(ImmersiveSceneBuilders.safetyMedicalBay(at: [3.5, 0, 0]))

        // Security desk zone
        let desk = makeBox(width: 2.8, height: 0.9, depth: 1.1, color: UIColor(red: 0.22, green: 0.28, blue: 0.42, alpha: 1))
        desk.position = [-3, 0.5, -3]
        root.addChild(desk)
        let deskTop = makeBox(width: 2.9, height: 0.05, depth: 1.15, color: .lightGray)
        deskTop.position = [-3, 0.98, -3]
        root.addChild(deskTop)

        for offset: Float in [-0.6, 0.6] {
            let monitor = makeBox(width: 0.55, height: 0.42, depth: 0.04, color: .black)
            monitor.position = [-3 + offset, 1.18, -3]
            root.addChild(monitor)
            let screen = makeBox(width: 0.5, height: 0.36, depth: 0.02, color: UIColor(red: 0.15, green: 0.45, blue: 0.85, alpha: 1))
            screen.position = [-3 + offset, 1.18, -2.96]
            root.addChild(screen)
        }

        for i in 0..<6 {
            let cctv = makeBox(width: 0.5, height: 0.35, depth: 0.04, color: .black)
            cctv.position = [-5 + Float(i) * 0.8, 1.85, -5.8]
            root.addChild(cctv)
            let feed = makeBox(width: 0.45, height: 0.3, depth: 0.02, color: UIColor(red: 0.1, green: 0.35, blue: 0.2, alpha: 1))
            feed.position = [-5 + Float(i) * 0.8, 1.85, -5.76]
            root.addChild(feed)
        }

        for (x, z) in [(-5.5 as Float, -4.5 as Float), (-5.5, -2.5)] {
            let aid = makeBox(width: 0.45, height: 0.45, depth: 0.12, color: .systemRed)
            aid.position = [x, 0.55, z]
            root.addChild(aid)
            let crossH = makeBox(width: 0.28, height: 0.07, depth: 0.14, color: .white)
            crossH.position = [x, 0.55, z + 0.08]
            root.addChild(crossH)
            let crossV = makeBox(width: 0.07, height: 0.28, depth: 0.14, color: .white)
            crossV.position = [x, 0.55, z + 0.08]
            root.addChild(crossV)
        }

        for z: Float in [-4.5, -2] {
            let extinguisher = makeCylinder(radius: 0.11, height: 0.6, color: .systemRed)
            extinguisher.position = [-6.2, 0.35, z]
            root.addChild(extinguisher)
        }

        let shield = makeBox(width: 0.55, height: 0.65, depth: 0.08, color: UIColor(red: 0.1, green: 0.25, blue: 0.55, alpha: 1))
        shield.position = [-1.5, 1.35, -3]
        root.addChild(shield)

        let exitSign = makeBox(width: 0.9, height: 0.35, depth: 0.05, color: .systemGreen)
        exitSign.position = [-3, 2.1, -5.85]
        root.addChild(exitSign)

        let safetySign = ImmersiveSceneBuilders.signPanel(
            text: "Safety & First Aid",
            width: 2.4,
            height: 0.5,
            color: UIColor(red: 0.75, green: 0.15, blue: 0.15, alpha: 1)
        )
        safetySign.position = [-3, 2.15, -5.7]
        root.addChild(safetySign)

        let medSign = ImmersiveSceneBuilders.signPanel(
            text: "Medical Room",
            width: 1.6,
            height: 0.45,
            color: UIColor(red: 0.15, green: 0.5, blue: 0.75, alpha: 1)
        )
        medSign.position = [3.5, 2.1, -5.5]
        root.addChild(medSign)

        ImmersiveSceneBuilders.addNurseryChildren(to: root, placements: [
            .init(position: [-4.5, 0, -1], isBoy: true, yaw: 0.4),
            .init(position: [-2, 0, -1.5], isBoy: false),
            .init(position: [-5, 0, 1.5], isBoy: false, yaw: -0.3),
            .init(position: [-3.5, 0, 2], isBoy: true)
        ])

        return root
    }
}
