import SwiftUI
import RealityKit

struct ReadingCornerView: View {
    var body: some View {
        AreaDetailCard(
            title: "Reading Corner",
            subtitle: "Quiet cozy library with 500+ books for all ages",
            icon: "books.vertical.fill",
            color: .purple,
            gradient: NurseryArea.readingCorner.themeGradient
        ) {
            AreaPreviewRealityView(area: .readingCorner)
        }
    }
}

// MARK: - Reading Corner Scene

enum ReadingCornerSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()
        root.position = [0, 0.0, -0.5]

        // Warm wood floor
        let floor = makeBox(width: 1.4, height: 0.025, depth: 1.4, color: .init(red: 0.75, green: 0.55, blue: 0.35, alpha: 1))
        floor.position = [0, -0.36, 0]
        root.addChild(floor)

        // Rug
        let rug = makeBox(width: 0.6, height: 0.028, depth: 0.5, color: .init(red: 0.55, green: 0.35, blue: 0.7, alpha: 1))
        rug.position = [0.05, -0.35, 0.05]
        root.addChild(rug)

        // Large bookshelf (back wall)
        let bigShelf = makeBox(width: 1.0, height: 0.5, depth: 0.12, color: .init(red: 0.55, green: 0.38, blue: 0.22, alpha: 1))
        bigShelf.position = [0, -0.1, -0.55]
        root.addChild(bigShelf)

        // Shelf planks
        for i in 0..<4 {
            let plank = makeBox(width: 1.01, height: 0.012, depth: 0.13, color: .init(red: 0.65, green: 0.48, blue: 0.3, alpha: 1))
            plank.position = [0, -0.32 + Float(i) * 0.12, -0.55]
            root.addChild(plank)
        }

        // Books in rows on shelf
        let bookColors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange,
                                      .systemPurple, .systemTeal, .systemPink, .systemYellow,
                                      .systemCyan, .systemBrown, .systemMint, .systemIndigo]
        for row in 0..<3 {
            for col in 0..<12 {
                let heightJitter = Float((row + col) % 3) * 0.008
                let book = makeBox(
                    width: 0.04, height: 0.09 + heightJitter,
                    depth: 0.07, color: bookColors[(row * 4 + col) % bookColors.count]
                )
                book.position = [-0.44 + Float(col) * 0.08, -0.28 + Float(row) * 0.12, -0.49]
                root.addChild(book)
            }
        }

        // Cushioned reading seat (beanbag style)
        let bag = makeSphere(radius: 0.14, color: .init(red: 0.95, green: 0.85, blue: 0.4, alpha: 1))
        bag.position = [0.28, -0.22, 0.15]
        root.addChild(bag)
        // Flatten the bean bag
        bag.scale = [1.3, 0.65, 1.3]

        // Second cushion
        let cushion2 = makeSphere(radius: 0.11, color: .init(red: 0.9, green: 0.5, blue: 0.7, alpha: 1))
        cushion2.position = [-0.2, -0.25, 0.2]
        cushion2.scale = [1.2, 0.6, 1.2]
        root.addChild(cushion2)

        // Small reading lamp
        let lampBase = makeCylinder(radius: 0.025, height: 0.03, color: .init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1))
        lampBase.position = [-0.52, -0.34, -0.25]
        root.addChild(lampBase)

        let lampPole = makeCylinder(radius: 0.008, height: 0.28, color: .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
        lampPole.position = [-0.52, -0.2, -0.25]
        root.addChild(lampPole)

        let lampShade = makeSphere(radius: 0.06, color: .init(red: 1.0, green: 0.9, blue: 0.5, alpha: 0.9))
        lampShade.position = [-0.52, -0.05, -0.25]
        root.addChild(lampShade)

        // Open book on the floor rug
        let bookL = makeBox(width: 0.12, height: 0.008, depth: 0.1, color: .init(red: 0.95, green: 0.92, blue: 0.86, alpha: 1))
        bookL.position = [-0.04, -0.325, 0.12]
        bookL.transform.rotation = simd_quatf(angle: .pi / 8, axis: [0, 1, 0])
        root.addChild(bookL)

        return root
    }
}
