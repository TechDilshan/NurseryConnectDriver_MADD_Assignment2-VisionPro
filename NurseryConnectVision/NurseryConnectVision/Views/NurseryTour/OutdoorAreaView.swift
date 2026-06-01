import SwiftUI
import RealityKit

struct OutdoorAreaView: View {
    var body: some View {
        AreaDetailCard(
            title: "Outdoor Garden",
            subtitle: "Secure garden for fresh air and nature exploration",
            icon: "leaf.fill",
            color: .mint,
            gradient: NurseryArea.outdoorGarden.themeGradient
        ) {
            AreaPreviewRealityView(area: .outdoorGarden)
        }
    }
}

// MARK: - Outdoor Garden Scene

enum OutdoorSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()
        root.position = [0, 0.0, -0.5]

        // Grass ground
        let grass = makeBox(width: 1.4, height: 0.025, depth: 1.4, color: .init(red: 0.35, green: 0.65, blue: 0.25, alpha: 1))
        grass.position = [0, -0.36, 0]
        root.addChild(grass)

        // Path (lighter stone)
        let path = makeBox(width: 0.2, height: 0.026, depth: 1.1, color: .init(red: 0.82, green: 0.78, blue: 0.72, alpha: 1))
        path.position = [0, -0.35, 0]
        root.addChild(path)

        // Trees
        for pos: (Float, Float) in [(-0.5, -0.4), (0.5, -0.4), (-0.55, 0.3)] {
            let tree = makeTree()
            tree.position = [pos.0, -0.1, pos.1]
            root.addChild(tree)
        }

        // Raised planting beds
        for i in 0..<2 {
            let bed = makeBox(width: 0.26, height: 0.06, depth: 0.16, color: .init(red: 0.5, green: 0.32, blue: 0.18, alpha: 1))
            bed.position = [0.4, -0.3, -0.25 + Float(i) * 0.25]
            root.addChild(bed)

            let soil = makeBox(width: 0.24, height: 0.015, depth: 0.14, color: .init(red: 0.3, green: 0.2, blue: 0.1, alpha: 1))
            soil.position = [0.4, -0.265, -0.25 + Float(i) * 0.25]
            root.addChild(soil)

            // Small plants in beds
            for j in 0..<3 {
                let plant = makeBox(width: 0.02, height: 0.06, depth: 0.02, color: .init(red: 0.3, green: 0.7, blue: 0.3, alpha: 1))
                plant.position = [0.3 + Float(j) * 0.05, -0.22, -0.25 + Float(i) * 0.25]
                root.addChild(plant)
            }
        }

        // Mud kitchen
        let mudKitchen = makeBox(width: 0.25, height: 0.2, depth: 0.15, color: .init(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        mudKitchen.position = [-0.35, -0.25, -0.45]
        root.addChild(mudKitchen)

        let mudCounter = makeBox(width: 0.27, height: 0.015, depth: 0.15, color: .init(red: 0.65, green: 0.5, blue: 0.3, alpha: 1))
        mudCounter.position = [-0.35, -0.15, -0.45]
        root.addChild(mudCounter)

        // Fence posts around perimeter
        for i in stride(from: Float(-0.6), through: 0.6, by: 0.15) {
            let post = makeCylinder(radius: 0.015, height: 0.3, color: .init(red: 0.7, green: 0.55, blue: 0.38, alpha: 1))
            post.position = [i, -0.2, -0.58]
            root.addChild(post)
        }
        // Fence rail
        let rail = makeBox(width: 1.2, height: 0.01, depth: 0.01, color: .init(red: 0.7, green: 0.55, blue: 0.38, alpha: 1))
        rail.position = [0, -0.12, -0.58]
        root.addChild(rail)

        // Watering can
        let can = makeBox(width: 0.06, height: 0.1, depth: 0.06, color: .init(red: 0.3, green: 0.7, blue: 0.9, alpha: 1))
        can.position = [0.2, -0.28, 0.2]
        root.addChild(can)

        return root
    }

    private static func makeTree() -> Entity {
        let tree = Entity()
        // Trunk
        let trunk = makeCylinder(radius: 0.025, height: 0.22, color: .init(red: 0.45, green: 0.3, blue: 0.15, alpha: 1))
        trunk.position = [0, 0, 0]
        tree.addChild(trunk)
        // Foliage layers
        let foliage1 = makeSphere(radius: 0.12, color: .init(red: 0.2, green: 0.62, blue: 0.25, alpha: 1))
        foliage1.position = [0, 0.2, 0]
        tree.addChild(foliage1)
        let foliage2 = makeSphere(radius: 0.09, color: .init(red: 0.15, green: 0.72, blue: 0.3, alpha: 1))
        foliage2.position = [0, 0.32, 0]
        tree.addChild(foliage2)
        let foliage3 = makeSphere(radius: 0.06, color: .init(red: 0.25, green: 0.8, blue: 0.35, alpha: 1))
        foliage3.position = [0, 0.41, 0]
        tree.addChild(foliage3)
        return tree
    }
}
