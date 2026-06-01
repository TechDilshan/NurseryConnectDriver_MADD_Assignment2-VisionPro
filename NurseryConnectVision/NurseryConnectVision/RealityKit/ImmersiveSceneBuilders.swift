import RealityKit
import UIKit

// MARK: - Shared immersive 3D builders

enum ImmersiveSceneBuilders {

    // MARK: Signs & labels

    static func signPanel(
        text: String,
        width: Float = 2.0,
        height: Float = 0.55,
        color: UIColor = UIColor(red: 0.12, green: 0.42, blue: 0.72, alpha: 1)
    ) -> Entity {
        let panel = NurseryEntity.makeTextPanel(text: text, width: width, height: height, color: color)
        let frame = makeBox(width: width + 0.08, height: height + 0.08, depth: 0.04, color: .white)
        frame.position = [0, 0, -0.02]
        panel.addChild(frame)
        return panel
    }

    // MARK: Nature

    static func realisticTree(variant: Int = 0) -> Entity {
        let tree = Entity()
        let trunkH: Float = variant % 2 == 0 ? 1.1 : 0.85
        let trunk = makeCylinder(radius: 0.14, height: trunkH, color: UIColor(red: 0.42, green: 0.28, blue: 0.14, alpha: 1))
        trunk.position = [0, trunkH / 2, 0]
        tree.addChild(trunk)

        let greens: [UIColor] = [
            UIColor(red: 0.18, green: 0.55, blue: 0.22, alpha: 1),
            UIColor(red: 0.22, green: 0.62, blue: 0.28, alpha: 1),
            UIColor(red: 0.15, green: 0.48, blue: 0.2, alpha: 1)
        ]
        let r1: Float = variant % 3 == 0 ? 0.55 : 0.45
        let canopy1 = makeSphere(radius: r1, color: greens[variant % 3])
        canopy1.position = [0, trunkH + r1 * 0.55, 0]
        tree.addChild(canopy1)
        let canopy2 = makeSphere(radius: r1 * 0.72, color: greens[(variant + 1) % 3])
        canopy2.position = [0.15, trunkH + r1 * 0.9, 0.1]
        tree.addChild(canopy2)
        let canopy3 = makeSphere(radius: r1 * 0.5, color: greens[(variant + 2) % 3])
        canopy3.position = [-0.12, trunkH + r1 * 0.75, -0.08]
        tree.addChild(canopy3)

        for i in 0..<3 {
            let branch = makeCylinder(radius: 0.03, height: 0.35, color: UIColor(red: 0.38, green: 0.25, blue: 0.12, alpha: 1))
            let angle = Float(i) * 2.1
            branch.position = [cos(angle) * 0.12, trunkH * 0.75, sin(angle) * 0.12]
            branch.orientation = simd_quatf(angle: angle, axis: [0, 1, 0])
            tree.addChild(branch)
        }
        return tree
    }

    static func flowerBed(at position: SIMD3<Float>, width: Float = 2.2, depth: Float = 1.4) -> Entity {
        let bed = Entity()
        bed.position = position
        let soil = makeBox(width: width, height: 0.12, depth: depth, color: UIColor(red: 0.42, green: 0.26, blue: 0.14, alpha: 1))
        soil.position = [0, 0.1, 0]
        bed.addChild(soil)
        let colors: [UIColor] = [.systemRed, .systemPink, .systemYellow, .systemPurple, .systemOrange, .white]
        let cols = Int(width / 0.35)
        let rows = Int(depth / 0.35)
        for r in 0..<rows {
            for c in 0..<cols {
                let fx = -width / 2 + 0.25 + Float(c) * 0.38
                let fz = -depth / 2 + 0.2 + Float(r) * 0.38
                let stem = makeCylinder(radius: 0.012, height: 0.22, color: .systemGreen)
                stem.position = [fx, 0.28, fz]
                bed.addChild(stem)
                let flower = makeSphere(radius: 0.07, color: colors[(r + c) % colors.count])
                flower.position = [fx, 0.42, fz]
                bed.addChild(flower)
            }
        }
        let border = makeBox(width: width + 0.06, height: 0.06, depth: depth + 0.06, color: UIColor(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        border.position = [0, 0.06, 0]
        bed.addChild(border)
        return bed
    }

    static func pond(at position: SIMD3<Float>, radius: Float = 1.8) -> Entity {
        let group = Entity()
        group.position = position
        let rim = makeCylinder(radius: radius + 0.15, height: 0.08, color: UIColor(red: 0.55, green: 0.48, blue: 0.38, alpha: 1))
        rim.position = [0, 0.06, 0]
        group.addChild(rim)
        let water = makeCylinder(radius: radius, height: 0.06, color: UIColor(red: 0.2, green: 0.55, blue: 0.82, alpha: 1))
        water.position = [0, 0.08, 0]
        group.addChild(water)
        let deep = makeCylinder(radius: radius * 0.85, height: 0.04, color: UIColor(red: 0.12, green: 0.42, blue: 0.68, alpha: 1))
        deep.position = [0, 0.06, 0]
        group.addChild(deep)
        for i in 0..<8 {
            let angle = Float(i) / 8 * .pi * 2
            let rock = makeSphere(radius: 0.12, color: UIColor(white: 0.55, alpha: 1))
            rock.position = [cos(angle) * (radius + 0.2), 0.12, sin(angle) * (radius + 0.2)]
            rock.scale = [1.2, 0.7, 1.0]
            group.addChild(rock)
        }
        let lily = makeSphere(radius: 0.1, color: .systemGreen)
        lily.position = [0.3, 0.14, 0.2]
        lily.scale = [1.5, 0.15, 1.5]
        group.addChild(lily)
        return group
    }

    static func roadSegment(width: Float, depth: Float, at position: SIMD3<Float>, rotation: Float = 0) -> Entity {
        let road = makeBox(width: width, height: 0.03, depth: depth, color: UIColor(white: 0.35, alpha: 1))
        road.position = position
        road.orientation = simd_quatf(angle: rotation, axis: [0, 1, 0])
        let line = makeBox(width: width * 0.04, height: 0.035, depth: depth, color: .systemYellow)
        line.position = position + [0, 0.01, 0]
        line.orientation = road.orientation
        let parent = Entity()
        parent.addChild(road)
        parent.addChild(line)
        return parent
    }

    // MARK: Play area

    static func swimmingPoolComplex(at position: SIMD3<Float>) -> Entity {
        let complex = Entity()
        complex.position = position

        let deck = makeBox(width: 5.5, height: 0.06, depth: 4.5, color: UIColor(white: 0.88, alpha: 1))
        deck.position = [0, 0.08, 0]
        complex.addChild(deck)

        let pool = makeBox(width: 4.2, height: 0.4, depth: 3.2, color: UIColor(red: 0.15, green: 0.48, blue: 0.78, alpha: 1))
        pool.position = [0, 0.15, 0]
        complex.addChild(pool)
        let water = makeBox(width: 3.9, height: 0.06, depth: 2.9, color: UIColor(red: 0.35, green: 0.78, blue: 0.95, alpha: 1))
        water.position = [0, 0.38, 0]
        complex.addChild(water)

        for x: Float in [-1.8, 1.8] {
            let ladder = makeBox(width: 0.12, height: 0.55, depth: 0.35, color: .lightGray)
            ladder.position = [x, 0.35, 1.4]
            complex.addChild(ladder)
        }

        let sign = signPanel(
            text: "Swimming pool complex",
            width: 2.4,
            height: 0.6,
            color: UIColor(red: 0.08, green: 0.38, blue: 0.68, alpha: 1)
        )
        sign.position = [0, 1.35, 2.6]
        complex.addChild(sign)

        let chair = makeBox(width: 0.5, height: 0.08, depth: 0.9, color: .systemTeal)
        chair.position = [-2.2, 0.2, -1.5]
        complex.addChild(chair)
        let umbrella = makeCylinder(radius: 0.9, height: 0.04, color: .systemRed)
        umbrella.position = [-2.2, 1.1, -1.5]
        complex.addChild(umbrella)
        let pole = makeCylinder(radius: 0.04, height: 1.0, color: .lightGray)
        pole.position = [-2.2, 0.55, -1.5]
        complex.addChild(pole)

        return complex
    }

    static func gymComplex(at position: SIMD3<Float>) -> Entity {
        let gym = Entity()
        gym.position = position

        let floor = makeBox(width: 5, height: 0.04, depth: 4.5, color: UIColor(red: 0.25, green: 0.28, blue: 0.32, alpha: 1))
        floor.position = [0, 0.1, 0]
        gym.addChild(floor)

        let wallBack = makeBox(width: 5, height: 2.2, depth: 0.1, color: UIColor(white: 0.9, alpha: 1))
        wallBack.position = [0, 1.15, -2.2]
        gym.addChild(wallBack)

        let sign = signPanel(text: "Nursery Gym", width: 1.6, height: 0.45, color: UIColor(red: 0.35, green: 0.35, blue: 0.4, alpha: 1))
        sign.position = [0, 1.85, -2.05]
        gym.addChild(sign)

        // Treadmill
        let treadmill = makeBox(width: 0.9, height: 0.35, depth: 1.6, color: .darkGray)
        treadmill.position = [-1.5, 0.3, 0.5]
        gym.addChild(treadmill)
        let belt = makeBox(width: 0.7, height: 0.04, depth: 1.2, color: .black)
        belt.position = [-1.5, 0.5, 0.5]
        gym.addChild(belt)
        let console = makeBox(width: 0.35, height: 0.5, depth: 0.08, color: .systemBlue)
        console.position = [-1.5, 0.75, -0.25]
        gym.addChild(console)

        // Weight bench
        let bench = makeBox(width: 0.5, height: 0.12, depth: 1.2, color: .black)
        bench.position = [0.5, 0.28, 0.8]
        gym.addChild(bench)
        let barbell = makeCylinder(radius: 0.03, height: 1.4, color: .lightGray)
        barbell.position = [0.5, 0.55, 0.8]
        barbell.orientation = simd_quatf(angle: .pi / 2, axis: [0, 0, 1])
        gym.addChild(barbell)
        for x: Float in [-0.65, 0.65] {
            let plate = makeCylinder(radius: 0.14, height: 0.05, color: .darkGray)
            plate.position = [0.5 + x, 0.55, 0.8]
            plate.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
            gym.addChild(plate)
        }

        // Dumbbell rack
        let rack = makeBox(width: 0.15, height: 0.9, depth: 0.8, color: .darkGray)
        rack.position = [1.8, 0.5, -0.5]
        gym.addChild(rack)
        for i in 0..<4 {
            let dumb = makeCylinder(radius: 0.05, height: 0.25, color: .lightGray)
            dumb.position = [1.8, 0.35 + Float(i) * 0.2, -0.5]
            dumb.orientation = simd_quatf(angle: .pi / 2, axis: [0, 0, 1])
            gym.addChild(dumb)
        }

        // Exercise mat
        let mat = makeBox(width: 1.2, height: 0.03, depth: 0.7, color: .systemPurple)
        mat.position = [-0.3, 0.12, -1.2]
        gym.addChild(mat)

        // Punching bag
        let bag = makeCylinder(radius: 0.18, height: 0.9, color: .systemRed)
        bag.position = [1.6, 0.6, 1.2]
        gym.addChild(bag)
        let chain = makeCylinder(radius: 0.02, height: 0.4, color: .lightGray)
        chain.position = [1.6, 1.25, 1.2]
        gym.addChild(chain)

        return gym
    }

    static func netballComplex(at position: SIMD3<Float>) -> Entity {
        let court = Entity()
        court.position = position

        let surface = makeBox(width: 5.5, height: 0.03, depth: 4.5, color: UIColor(red: 0.88, green: 0.35, blue: 0.55, alpha: 1))
        surface.position = [0, 0.1, 0]
        court.addChild(surface)

        let sign = signPanel(text: "Netball complex", width: 1.8, height: 0.5, color: UIColor(red: 0.65, green: 0.15, blue: 0.35, alpha: 1))
        sign.position = [0, 1.5, 2.5]
        court.addChild(sign)

        for z: Float in [-1.8, 1.8] {
            let pole = makeCylinder(radius: 0.05, height: 2.4, color: .white)
            pole.position = [0, 1.25, z]
            court.addChild(pole)
            let ring = makeCylinder(radius: 0.2, height: 0.03, color: .systemOrange)
            ring.position = [0, 2.2, z]
            ring.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
            court.addChild(ring)
        }

        for x: Float in [-2.2, 2.2] {
            let post = makeBox(width: 0.08, height: 1.5, depth: 0.08, color: .white)
            post.position = [x, 0.8, 0]
            court.addChild(post)
        }

        let center = makeCylinder(radius: 0.25, height: 0.02, color: .white)
        center.position = [0, 0.13, 0]
        court.addChild(center)

        return court
    }

    // MARK: Dining

    static func lunchTableWithPlaceSettings() -> Entity {
        let g = Entity()
        let top = makeBox(width: 1.3, height: 0.06, depth: 0.85, color: UIColor(red: 0.82, green: 0.62, blue: 0.4, alpha: 1))
        top.position = [0, 0.45, 0]
        g.addChild(top)
        let leg = makeCylinder(radius: 0.09, height: 0.42, color: .brown)
        leg.position = [0, 0.22, 0]
        g.addChild(leg)

        let offsets: [SIMD2<Float>] = [[-0.48, 0.32], [0.48, 0.32], [-0.48, -0.32], [0.48, -0.32]]
        for offset in offsets {
            let chair = makeBox(width: 0.36, height: 0.05, depth: 0.36, color: .systemRed)
            chair.position = [offset.x, 0.24, offset.y]
            g.addChild(chair)
            addPlaceSetting(to: g, at: [offset.x * 0.55, 0.52, offset.y * 0.55])
        }
        addPlaceSetting(to: g, at: [0, 0.52, 0])
        return g
    }

    private static func addPlaceSetting(to parent: Entity, at position: SIMD3<Float>) {
        let plate = makeCylinder(radius: 0.12, height: 0.015, color: .white)
        plate.position = position
        parent.addChild(plate)
        let food = makeSphere(radius: 0.06, color: UIColor(red: 0.85, green: 0.65, blue: 0.35, alpha: 1))
        food.position = position + [0, 0.04, 0]
        parent.addChild(food)
        let cup = makeCylinder(radius: 0.04, height: 0.1, color: .systemBlue)
        cup.position = position + [0.18, 0.06, 0]
        parent.addChild(cup)
    }

    static func canteenCounter(at position: SIMD3<Float>) -> Entity {
        let canteen = Entity()
        canteen.position = position

        let base = makeBox(width: 6, height: 1.0, depth: 0.75, color: UIColor(red: 0.72, green: 0.52, blue: 0.32, alpha: 1))
        base.position = [0, 0.55, 0]
        canteen.addChild(base)
        let top = makeBox(width: 6.2, height: 0.06, depth: 0.8, color: UIColor(red: 0.94, green: 0.9, blue: 0.84, alpha: 1))
        top.position = [0, 1.12, 0]
        canteen.addChild(top)

        let sign = signPanel(text: "Canteen", width: 1.4, height: 0.4, color: UIColor(red: 0.75, green: 0.45, blue: 0.15, alpha: 1))
        sign.position = [0, 1.75, -0.2]
        canteen.addChild(sign)

        let foodColors: [UIColor] = [
            UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 1),
            UIColor(red: 0.4, green: 0.75, blue: 0.35, alpha: 1),
            UIColor(red: 0.95, green: 0.8, blue: 0.3, alpha: 1),
            UIColor(red: 0.85, green: 0.35, blue: 0.3, alpha: 1)
        ]
        for i in 0..<5 {
            let tray = makeBox(width: 0.55, height: 0.05, depth: 0.4, color: .systemOrange)
            tray.position = [-2.0 + Float(i) * 1.0, 1.18, 0]
            canteen.addChild(tray)
            let dish = makeBox(width: 0.35, height: 0.12, depth: 0.28, color: foodColors[i % foodColors.count])
            dish.position = [-2.0 + Float(i) * 1.0, 1.28, 0]
            canteen.addChild(dish)
        }

        let warmer = makeBox(width: 1.2, height: 0.5, depth: 0.6, color: .darkGray)
        warmer.position = [2.2, 1.25, 0]
        canteen.addChild(warmer)
        let steam = makeSphere(radius: 0.08, color: UIColor(white: 0.9, alpha: 0.6))
        steam.position = [2.2, 1.55, 0]
        canteen.addChild(steam)

        let fruitColors: [UIColor] = [.systemRed, .systemGreen, .systemOrange]
        for i in 0..<3 {
            let fruit = makeSphere(radius: 0.08, color: fruitColors[i])
            fruit.position = [-2.5 + Float(i) * 0.25, 1.32, 0.35]
            canteen.addChild(fruit)
        }

        return canteen
    }

    static func washBasinStation(at position: SIMD3<Float>) -> Entity {
        let station = Entity()
        station.position = position

        let wall = makeBox(width: 3.2, height: 1.6, depth: 0.1, color: UIColor(white: 0.92, alpha: 1))
        wall.position = [0, 0.85, -0.35]
        station.addChild(wall)

        let mirror = makeBox(width: 2.4, height: 0.9, depth: 0.03, color: UIColor(red: 0.75, green: 0.82, blue: 0.9, alpha: 1))
        mirror.position = [0, 1.2, -0.28]
        station.addChild(mirror)

        for i in 0..<3 {
            let x = -0.9 + Float(i) * 0.9
            let vanity = makeBox(width: 0.75, height: 0.85, depth: 0.45, color: .white)
            vanity.position = [x, 0.48, 0]
            station.addChild(vanity)
            let basin = makeBox(width: 0.45, height: 0.14, depth: 0.32, color: UIColor(red: 0.88, green: 0.92, blue: 0.96, alpha: 1))
            basin.position = [x, 0.95, 0.05]
            station.addChild(basin)
            let tap = makeCylinder(radius: 0.025, height: 0.2, color: .lightGray)
            tap.position = [x, 1.05, -0.08]
            station.addChild(tap)
            let soap = makeBox(width: 0.08, height: 0.06, depth: 0.05, color: .systemTeal)
            soap.position = [x + 0.25, 0.92, 0.1]
            station.addChild(soap)
            let dryer = makeBox(width: 0.12, height: 0.18, depth: 0.1, color: .white)
            dryer.position = [x - 0.3, 1.0, 0.15]
            station.addChild(dryer)
        }

        let sign = signPanel(text: "Wash basins", width: 1.2, height: 0.35, color: UIColor(red: 0.2, green: 0.55, blue: 0.7, alpha: 1))
        sign.position = [0, 1.55, -0.25]
        station.addChild(sign)

        return station
    }

    // MARK: Library / reading

    static func bookRack(width: Float = 2.4, shelves: Int = 5) -> Entity {
        let rack = Entity()
        let frame = makeBox(width: width, height: Float(shelves) * 0.38 + 0.2, depth: 0.32, color: UIColor(red: 0.48, green: 0.32, blue: 0.18, alpha: 1))
        frame.position = [0, Float(shelves) * 0.19, 0]
        rack.addChild(frame)
        let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemTeal, .systemIndigo]
        for s in 0..<shelves {
            for b in 0..<Int(width / 0.14) {
                let book = makeBox(width: 0.1, height: 0.28, depth: 0.18, color: colors[(s + b) % colors.count])
                book.position = [-width / 2 + 0.12 + Float(b) * 0.14, 0.22 + Float(s) * 0.38, 0.08]
                rack.addChild(book)
            }
        }
        return rack
    }

    static func readingTableWithLamp() -> Entity {
        let table = Entity()
        let top = makeBox(width: 1.1, height: 0.05, depth: 0.7, color: UIColor(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        top.position = [0, 0.42, 0]
        table.addChild(top)
        for x: Float in [-0.45, 0.45] {
            let leg = makeBox(width: 0.05, height: 0.4, depth: 0.05, color: .brown)
            leg.position = [x, 0.2, 0.28]
            table.addChild(leg)
            let leg2 = makeBox(width: 0.05, height: 0.4, depth: 0.05, color: .brown)
            leg2.position = [x, 0.2, -0.28]
            table.addChild(leg2)
        }
        let book = makeBox(width: 0.35, height: 0.04, depth: 0.25, color: .systemBlue)
        book.position = [0, 0.47, 0]
        table.addChild(book)
        let openBook = makeBox(width: 0.3, height: 0.02, depth: 0.2, color: .white)
        openBook.position = [0.15, 0.465, 0.1]
        openBook.orientation = simd_quatf(angle: 0.15, axis: [0, 1, 0])
        table.addChild(openBook)

        let lampBase = makeCylinder(radius: 0.08, height: 0.04, color: .darkGray)
        lampBase.position = [-0.35, 0.47, 0.2]
        table.addChild(lampBase)
        let lampArm = makeBox(width: 0.04, height: 0.35, depth: 0.04, color: .darkGray)
        lampArm.position = [-0.35, 0.65, 0.2]
        table.addChild(lampArm)
        let shade = makeCylinder(radius: 0.12, height: 0.1, color: UIColor(red: 0.98, green: 0.92, blue: 0.7, alpha: 1))
        shade.position = [-0.35, 0.85, 0.2]
        table.addChild(shade)
        let bulb = makeSphere(radius: 0.04, color: UIColor(red: 1, green: 0.95, blue: 0.75, alpha: 1))
        bulb.position = [-0.35, 0.78, 0.2]
        table.addChild(bulb)

        let chair = makeBox(width: 0.4, height: 0.05, depth: 0.4, color: .systemIndigo)
        chair.position = [0, 0.22, 0.55]
        table.addChild(chair)

        return table
    }

    static func addWall(to root: Entity, width: Float, height: Float, at position: SIMD3<Float>, depth: Float = 0.12) {
        let wall = makeBox(width: width, height: height, depth: depth, color: UIColor(red: 0.9, green: 0.88, blue: 0.84, alpha: 1))
        wall.position = position
        root.addChild(wall)
    }

    // MARK: - Nursery children (boys & girls)

    struct ChildPlacement {
        let position: SIMD3<Float>
        let isBoy: Bool
        var yaw: Float = 0
    }

    static func addNurseryChildren(to root: Entity, placements: [ChildPlacement]) {
        for placement in placements {
            let child = nurseryChild(isBoy: placement.isBoy)
            child.position = placement.position
            if placement.yaw != 0 {
                child.orientation = simd_quatf(angle: placement.yaw, axis: [0, 1, 0])
            }
            root.addChild(child)
        }
    }

    /// Procedural nursery child — boys (shirt/shorts) and girls (dress, longer hair).
    static func nurseryChild(isBoy: Bool) -> Entity {
        let child = Entity()
        child.name = isBoy ? "NurseryBoy" : "NurseryGirl"

        let skin = UIColor(red: 0.98, green: 0.86, blue: 0.74, alpha: 1)
        let shoe = UIColor(red: 0.25, green: 0.25, blue: 0.28, alpha: 1)

        for x: Float in [-0.08, 0.08] {
            let leg = makeBox(width: 0.09, height: 0.22, depth: 0.1, color: isBoy ? .systemBlue : UIColor(red: 0.85, green: 0.35, blue: 0.55, alpha: 1))
            leg.position = [x, 0.14, 0]
            child.addChild(leg)
            let foot = makeBox(width: 0.1, height: 0.04, depth: 0.14, color: shoe)
            foot.position = [x, 0.03, 0.02]
            child.addChild(foot)
        }

        let torsoColor: UIColor = isBoy
            ? UIColor(red: 0.2, green: 0.45, blue: 0.85, alpha: 1)
            : UIColor(red: 0.9, green: 0.4, blue: 0.62, alpha: 1)
        let torso = makeBox(width: 0.22, height: 0.26, depth: 0.14, color: torsoColor)
        torso.position = [0, 0.38, 0]
        child.addChild(torso)

        if !isBoy {
            let skirt = makeBox(width: 0.26, height: 0.12, depth: 0.16, color: UIColor(red: 0.75, green: 0.28, blue: 0.52, alpha: 1))
            skirt.position = [0, 0.28, 0]
            child.addChild(skirt)
        }

        let head = makeSphere(radius: 0.11, color: skin)
        head.position = [0, 0.58, 0]
        child.addChild(head)

        if isBoy {
            let hair = makeBox(width: 0.18, height: 0.06, depth: 0.16, color: UIColor(red: 0.35, green: 0.22, blue: 0.12, alpha: 1))
            hair.position = [0, 0.67, -0.02]
            child.addChild(hair)
        } else {
            let hairBack = makeSphere(radius: 0.09, color: UIColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1))
            hairBack.position = [0, 0.62, -0.1]
            hairBack.scale = [1, 1.2, 0.8]
            child.addChild(hairBack)
            for x: Float in [-0.1, 0.1] {
                let bun = makeSphere(radius: 0.05, color: UIColor(red: 0.45, green: 0.28, blue: 0.15, alpha: 1))
                bun.position = [x, 0.68, -0.06]
                child.addChild(bun)
            }
        }

        let armColor = skin
        for x: Float in [-0.16, 0.16] {
            let arm = makeCylinder(radius: 0.035, height: 0.18, color: armColor)
            arm.position = [x, 0.36, 0]
            child.addChild(arm)
        }

        return child
    }

    // MARK: - Safety & medical

    static func hospitalBed(at position: SIMD3<Float>, withChild isBoy: Bool? = nil) -> Entity {
        let bed = Entity()
        bed.position = position

        let frame = makeBox(width: 2.1, height: 0.35, depth: 1.0, color: UIColor(white: 0.85, alpha: 1))
        frame.position = [0, 0.22, 0]
        bed.addChild(frame)

        let mattress = makeBox(width: 1.95, height: 0.12, depth: 0.9, color: .white)
        mattress.position = [0, 0.42, 0]
        bed.addChild(mattress)

        let pillow = makeBox(width: 0.45, height: 0.1, depth: 0.35, color: UIColor(red: 0.9, green: 0.92, blue: 0.98, alpha: 1))
        pillow.position = [0.65, 0.52, 0]
        bed.addChild(pillow)

        let blanket = makeBox(width: 1.4, height: 0.06, depth: 0.75, color: UIColor(red: 0.55, green: 0.72, blue: 0.9, alpha: 1))
        blanket.position = [-0.15, 0.5, 0]
        bed.addChild(blanket)

        let railL = makeBox(width: 0.05, height: 0.45, depth: 1.0, color: .lightGray)
        railL.position = [-1.0, 0.55, 0]
        bed.addChild(railL)
        let railR = makeBox(width: 0.05, height: 0.45, depth: 1.0, color: .lightGray)
        railR.position = [1.0, 0.55, 0]
        bed.addChild(railR)

        let ivPole = makeCylinder(radius: 0.025, height: 1.6, color: .lightGray)
        ivPole.position = [-1.15, 0.85, 0.35]
        bed.addChild(ivPole)
        let ivBag = makeBox(width: 0.2, height: 0.28, depth: 0.08, color: UIColor(red: 0.75, green: 0.9, blue: 1, alpha: 0.9))
        ivBag.position = [-1.15, 1.55, 0.35]
        bed.addChild(ivBag)

        if let isBoy {
            let patient = nurseryChild(isBoy: isBoy)
            patient.position = [-0.1, 0.48, 0]
            patient.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
            patient.scale = [0.95, 0.95, 0.95]
            bed.addChild(patient)
        }

        return bed
    }

    static func safetyMedicalBay(at position: SIMD3<Float>) -> Entity {
        let bay = Entity()
        bay.position = position

        let partition = makeBox(width: 0.08, height: 2.2, depth: 5, color: UIColor(white: 0.92, alpha: 1))
        partition.position = [-2.5, 1.1, 0]
        bay.addChild(partition)

        bay.addChild(hospitalBed(at: [0, 0, -1.2], withChild: true))
        bay.addChild(hospitalBed(at: [0, 0, 1.2], withChild: false))

        let cabinet = makeBox(width: 0.9, height: 1.4, depth: 0.45, color: .white)
        cabinet.position = [2.2, 0.75, 0]
        bay.addChild(cabinet)
        let cross = makeBox(width: 0.35, height: 0.35, depth: 0.04, color: .systemRed)
        cross.position = [2.2, 1.2, 0.24]
        bay.addChild(cross)

        let wheelchair = makeBox(width: 0.55, height: 0.45, depth: 0.7, color: .darkGray)
        wheelchair.position = [2.2, 0.28, -1.5]
        bay.addChild(wheelchair)
        for x: Float in [-0.22, 0.22] {
            let wheel = makeCylinder(radius: 0.14, height: 0.04, color: .black)
            wheel.position = [2.2 + x, 0.14, -1.65]
            wheel.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
            bay.addChild(wheel)
        }

        let stretcher = makeBox(width: 1.8, height: 0.12, depth: 0.65, color: UIColor(red: 0.2, green: 0.55, blue: 0.75, alpha: 1))
        stretcher.position = [-0.5, 0.35, 2.2]
        bay.addChild(stretcher)

        let aed = makeBox(width: 0.35, height: 0.4, depth: 0.12, color: .systemGreen)
        aed.position = [2.2, 1.0, 1.4]
        bay.addChild(aed)
        let aedLabel = makeBox(width: 0.25, height: 0.08, depth: 0.02, color: .white)
        aedLabel.position = [2.2, 1.05, 1.47]
        bay.addChild(aedLabel)

        let sanitizer = makeBox(width: 0.25, height: 0.45, depth: 0.2, color: .white)
        sanitizer.position = [-2.0, 0.55, -2.0]
        bay.addChild(sanitizer)
        let gel = makeBox(width: 0.15, height: 0.2, depth: 0.1, color: UIColor(red: 0.4, green: 0.75, blue: 0.95, alpha: 0.8))
        gel.position = [-2.0, 0.75, -2.0]
        bay.addChild(gel)

        let alarm = makeBox(width: 0.2, height: 0.2, depth: 0.08, color: .systemRed)
        alarm.position = [-2.0, 1.8, 2.0]
        bay.addChild(alarm)

        let vest = makeBox(width: 0.4, height: 0.5, depth: 0.08, color: .systemYellow)
        vest.position = [2.2, 1.5, -2.0]
        bay.addChild(vest)

        let helmet = makeSphere(radius: 0.12, color: .systemYellow)
        helmet.position = [2.5, 1.55, -2.0]
        bay.addChild(helmet)

        let cone = makeCylinder(radius: 0.12, height: 0.35, color: .systemOrange)
        cone.position = [-1.5, 0.2, 2.5]
        bay.addChild(cone)

        let phone = makeBox(width: 0.2, height: 0.08, depth: 0.15, color: .systemRed)
        phone.position = [-2.0, 1.0, 0]
        bay.addChild(phone)

        return bay
    }
}
