import RealityKit
import UIKit

/// Surrounds immersive area scenes with a Little Stars Nursery world (replaces simulator passthrough).
enum ImmersiveNurseryEnvironment {

    static func build(for area: NurseryArea) -> Entity {
        let root = Entity()
        root.name = "NurseryWorldEnvironment"

        let palette = palette(for: area)

        addGround(to: root, palette: palette)
        addSkyAndWalls(to: root, palette: palette)
        addNurseryDecor(to: root, area: area, palette: palette)
        addSoftLightPanels(to: root, palette: palette)

        return root
    }

    // MARK: - Palette

    private struct EnvironmentPalette {
        let ground: UIColor
        let sky: UIColor
        let wall: UIColor
        let accent: UIColor
        let isOutdoor: Bool
    }

    private static func palette(for area: NurseryArea) -> EnvironmentPalette {
        switch area {
        case .classroom:
            return EnvironmentPalette(
                ground: UIColor(red: 0.88, green: 0.84, blue: 0.78, alpha: 1),
                sky: UIColor(red: 0.82, green: 0.9, blue: 0.98, alpha: 1),
                wall: UIColor(red: 0.92, green: 0.94, blue: 0.97, alpha: 1),
                accent: UIColor(red: 0.2, green: 0.45, blue: 0.85, alpha: 1),
                isOutdoor: false
            )
        case .playArea:
            return EnvironmentPalette(
                ground: UIColor(red: 0.28, green: 0.62, blue: 0.3, alpha: 1),
                sky: UIColor(red: 0.55, green: 0.78, blue: 0.95, alpha: 1),
                wall: UIColor(red: 0.7, green: 0.85, blue: 0.65, alpha: 1),
                accent: UIColor(red: 0.9, green: 0.5, blue: 0.15, alpha: 1),
                isOutdoor: true
            )
        case .diningArea:
            return EnvironmentPalette(
                ground: UIColor(red: 0.9, green: 0.86, blue: 0.8, alpha: 1),
                sky: UIColor(red: 0.95, green: 0.92, blue: 0.88, alpha: 1),
                wall: UIColor(red: 0.98, green: 0.95, blue: 0.9, alpha: 1),
                accent: UIColor(red: 0.35, green: 0.65, blue: 0.35, alpha: 1),
                isOutdoor: false
            )
        case .outdoorGarden:
            return EnvironmentPalette(
                ground: UIColor(red: 0.24, green: 0.55, blue: 0.22, alpha: 1),
                sky: UIColor(red: 0.5, green: 0.75, blue: 0.92, alpha: 1),
                wall: UIColor(red: 0.45, green: 0.7, blue: 0.4, alpha: 1),
                accent: UIColor(red: 0.2, green: 0.7, blue: 0.55, alpha: 1),
                isOutdoor: true
            )
        case .readingCorner:
            return EnvironmentPalette(
                ground: UIColor(red: 0.62, green: 0.45, blue: 0.32, alpha: 1),
                sky: UIColor(red: 0.45, green: 0.35, blue: 0.55, alpha: 1),
                wall: UIColor(red: 0.55, green: 0.42, blue: 0.62, alpha: 1),
                accent: UIColor(red: 0.55, green: 0.35, blue: 0.75, alpha: 1),
                isOutdoor: false
            )
        case .safetyDesk:
            return EnvironmentPalette(
                ground: UIColor(red: 0.78, green: 0.8, blue: 0.82, alpha: 1),
                sky: UIColor(red: 0.88, green: 0.9, blue: 0.93, alpha: 1),
                wall: UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1),
                accent: UIColor(red: 0.75, green: 0.2, blue: 0.2, alpha: 1),
                isOutdoor: false
            )
        }
    }

    // MARK: - Geometry

    private static func addGround(to root: Entity, palette: EnvironmentPalette) {
        let ground = makeBox(width: 50, height: 0.15, depth: 50, color: palette.ground)
        ground.position = [0, -0.12, -2]
        root.addChild(ground)

        let path = makeBox(width: 4, height: 0.02, depth: 20, color: UIColor(white: 0.55, alpha: 1))
        path.position = [0, 0.02, -2]
        root.addChild(path)
    }

    private static func addSkyAndWalls(to root: Entity, palette: EnvironmentPalette) {
        let center: SIMD3<Float> = [0, 0, -2]

        let ceiling = makeBox(width: 48, height: 0.2, depth: 48, color: palette.sky)
        ceiling.position = center + [0, 14, 0]
        root.addChild(ceiling)

        let backWall = makeBox(width: 48, height: 16, depth: 0.25, color: palette.wall)
        backWall.position = center + [0, 7, -22]
        root.addChild(backWall)

        let frontGlow = makeBox(width: 48, height: 10, depth: 0.1, color: palette.sky.withAlphaComponent(0.6))
        frontGlow.position = center + [0, 5, 18]
        root.addChild(frontGlow)

        for x: Float in [-24, 24] {
            let side = makeBox(width: 0.25, height: 16, depth: 48, color: palette.wall)
            side.position = center + [x, 7, 0]
            root.addChild(side)
        }

        // Soft sky gradient bands
        for i in 0..<3 {
            let band = makeBox(width: 46, height: 2.5, depth: 0.08, color: palette.sky.withAlphaComponent(0.35 + CGFloat(i) * 0.15))
            band.position = center + [0, 10 + Float(i) * 2.5, -21.5]
            root.addChild(band)
        }
    }

    private static func addNurseryDecor(to root: Entity, area: NurseryArea, palette: EnvironmentPalette) {
        let sign = NurseryEntity.makeTextPanel(
            text: Constants.nurseryName,
            width: 3.2,
            height: 0.7,
            color: palette.accent
        )
        sign.position = [0, 9.5, -21.2]
        root.addChild(sign)

        let tagline = NurseryEntity.makeTextPanel(
            text: "NurseryConnect · \(area.title)",
            width: 2.8,
            height: 0.45,
            color: palette.accent.withAlphaComponent(0.85)
        )
        tagline.position = [0, 8.6, -21.15]
        root.addChild(tagline)

        if palette.isOutdoor {
            for i in 0..<8 {
                let angle = Float(i) / 8 * .pi * 2
                let tree = outdoorTree()
                tree.position = [cos(angle) * 20, 0, -2 + sin(angle) * 20]
                root.addChild(tree)
            }
            let fence = makeBox(width: 46, height: 1.2, depth: 0.08, color: UIColor(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
            fence.position = [0, 0.65, -20]
            root.addChild(fence)
        } else {
            for x: Float in [-8, 0, 8] {
                let banner = makeBox(width: 2.5, height: 0.6, depth: 0.05, color: palette.accent.withAlphaComponent(0.75))
                banner.position = [x, 11, -21]
                root.addChild(banner)
            }
        }

        // Clouds
        for i in 0..<5 {
            let cloud = makeSphere(radius: 0.8, color: UIColor(white: 1, alpha: 0.92))
            cloud.position = [-10 + Float(i) * 5, 12 + Float(i % 2), -8 + Float(i)]
            cloud.scale = [1.8, 0.5, 1.2]
            root.addChild(cloud)
        }
    }

    private static func outdoorTree() -> Entity {
        let tree = Entity()
        let trunk = makeCylinder(radius: 0.2, height: 1.2, color: UIColor(red: 0.4, green: 0.28, blue: 0.14, alpha: 1))
        trunk.position = [0, 0.65, 0]
        tree.addChild(trunk)
        let leaves = makeSphere(radius: 0.7, color: UIColor(red: 0.2, green: 0.55, blue: 0.25, alpha: 1))
        leaves.position = [0, 1.5, 0]
        tree.addChild(leaves)
        return tree
    }

    /// Bright panels (visionOS has no DirectionalLight); keeps scenes readable in full immersion.
    private static func addSoftLightPanels(to root: Entity, palette: EnvironmentPalette) {
        let center: SIMD3<Float> = [0, 0, -2]
        let glow = UIColor(red: 1, green: 0.98, blue: 0.92, alpha: 1)
        for x: Float in [-6, 0, 6] {
            let panel = makeBox(width: 2.5, height: 0.08, depth: 1.2, color: glow)
            panel.position = center + [x, 13.5, -4]
            root.addChild(panel)
        }
        let rim = makeBox(width: 44, height: 0.04, depth: 0.5, color: palette.accent.withAlphaComponent(0.35))
        rim.position = center + [0, 0.08, -2]
        root.addChild(rim)
    }
}
