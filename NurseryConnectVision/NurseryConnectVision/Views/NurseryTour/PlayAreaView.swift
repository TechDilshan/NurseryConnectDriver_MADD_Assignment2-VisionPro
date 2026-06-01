import SwiftUI
import RealityKit

struct PlayAreaView: View {
    var body: some View {
        AreaDetailCard(
            title: "Play Area",
            subtitle: "Supervised social play & physical development",
            icon: "figure.play",
            color: .orange,
            gradient: NurseryArea.playArea.themeGradient
        ) {
            AreaPreviewRealityView(area: .playArea)
        }
    }
}

// MARK: - Play Area Scene

enum PlayAreaSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()
        root.position = [0, 0.0, -0.5]

        // Padded floor (soft colourful mat)
        let mat = makeBox(width: 1.4, height: 0.03, depth: 1.4, color: .init(red: 0.9, green: 0.6, blue: 0.3, alpha: 1))
        mat.position = [0, -0.35, 0]
        root.addChild(mat)

        // Mat squares pattern
        let matColors: [UIColor] = [.systemBlue, .systemGreen, .systemYellow, .systemPink, .systemOrange, .systemPurple]
        for row in 0..<2 {
            for col in 0..<3 {
                let tile = makeBox(width: 0.18, height: 0.031, depth: 0.18, color: matColors[row * 3 + col].withAlphaComponent(1))
                tile.position = [-0.22 + Float(col) * 0.22, -0.34, -0.18 + Float(row) * 0.22]
                root.addChild(tile)
            }
        }

        // Slide structure
        let slideBase = makeBox(width: 0.08, height: 0.35, depth: 0.08, color: .init(red: 0.3, green: 0.6, blue: 0.9, alpha: 1))
        slideBase.position = [0.3, -0.18, -0.2]
        root.addChild(slideBase)

        // Slide ramp
        let slideRamp = makeBox(width: 0.12, height: 0.008, depth: 0.32, color: .init(red: 1.0, green: 0.75, blue: 0.1, alpha: 1))
        slideRamp.position = [0.2, -0.1, -0.06]
        slideRamp.transform.rotation = simd_quatf(angle: .pi / 5, axis: [1, 0, 0])
        root.addChild(slideRamp)

        // Platform on top
        let platform = makeBox(width: 0.2, height: 0.025, depth: 0.2, color: .init(red: 0.95, green: 0.4, blue: 0.3, alpha: 1))
        platform.position = [0.3, -0.0, -0.2]
        root.addChild(platform)

        // Climbing frame posts
        let framePositions: [(Float, Float)] = [(-0.3, -0.3), (-0.3, -0.1), (-0.1, -0.3), (-0.1, -0.1)]
        for pos in framePositions {
            let post = makeCylinder(radius: 0.015, height: 0.38, color: .init(red: 0.7, green: 0.4, blue: 0.2, alpha: 1))
            post.position = [pos.0, -0.16, pos.1]
            root.addChild(post)
        }
        // Cross bars
        let bar1 = makeBox(width: 0.2, height: 0.015, depth: 0.015, color: .init(red: 0.8, green: 0.5, blue: 0.2, alpha: 1))
        bar1.position = [-0.2, 0.0, -0.2]
        root.addChild(bar1)
        let bar2 = makeBox(width: 0.2, height: 0.015, depth: 0.015, color: .init(red: 0.8, green: 0.5, blue: 0.2, alpha: 1))
        bar2.position = [-0.2, -0.1, -0.2]
        root.addChild(bar2)

        // Balls scattered on floor
        let ballData: [(Float, Float, UIColor)] = [
            (-0.5, 0.1, .systemRed), (0.0, -0.4, .systemBlue), (-0.2, 0.2, .systemGreen),
            (0.45, 0.05, .systemYellow), (-0.4, -0.3, .systemOrange)
        ]
        for ball in ballData {
            let b = makeSphere(radius: 0.04, color: ball.2)
            b.position = [ball.0, -0.30, ball.1]
            root.addChild(b)
        }

        // Toy box
        let toyBox = makeBox(width: 0.2, height: 0.12, depth: 0.14, color: .init(red: 0.9, green: 0.3, blue: 0.5, alpha: 1))
        toyBox.position = [-0.5, -0.29, -0.35]
        root.addChild(toyBox)
        let toyBoxLid = makeBox(width: 0.21, height: 0.015, depth: 0.14, color: .init(red: 1.0, green: 0.5, blue: 0.65, alpha: 1))
        toyBoxLid.position = [-0.5, -0.22, -0.35]
        root.addChild(toyBoxLid)

        return root
    }
}
