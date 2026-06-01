import SwiftUI
import RealityKit

struct DiningAreaView: View {
    var body: some View {
        AreaDetailCard(
            title: "Dining Area",
            subtitle: "Fresh nutritious meals in a welcoming setting",
            icon: "fork.knife",
            color: .green,
            gradient: NurseryArea.diningArea.themeGradient
        ) {
            AreaPreviewRealityView(area: .diningArea)
        }
    }
}

// MARK: - Dining Scene

enum DiningSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()
        root.position = [0, 0.0, -0.5]

        // Floor (warm cream)
        let floor = makeBox(width: 1.4, height: 0.025, depth: 1.4, color: .init(red: 0.96, green: 0.93, blue: 0.87, alpha: 1))
        floor.position = [0, -0.36, 0]
        root.addChild(floor)

        // Two dining tables with chairs
        for tableOffset: Float in [-0.25, 0.25] {
            let table = makeDiningTable()
            table.position = [tableOffset, 0, 0]
            root.addChild(table)
        }

        // Food counter / serving station at back
        let counter = makeBox(width: 0.8, height: 0.14, depth: 0.2, color: .init(red: 0.85, green: 0.78, blue: 0.65, alpha: 1))
        counter.position = [0, -0.22, -0.5]
        root.addChild(counter)

        let counterTop = makeBox(width: 0.82, height: 0.01, depth: 0.22, color: .init(red: 0.95, green: 0.92, blue: 0.88, alpha: 1))
        counterTop.position = [0, -0.15, -0.5]
        root.addChild(counterTop)

        // Trays of food on counter
        let trayColors: [UIColor] = [.systemGreen, .systemOrange, .systemYellow]
        for (i, c) in trayColors.enumerated() {
            let tray = makeBox(width: 0.14, height: 0.02, depth: 0.1, color: .init(red: 0.85, green: 0.82, blue: 0.78, alpha: 1))
            tray.position = [-0.2 + Float(i) * 0.2, -0.14, -0.5]
            root.addChild(tray)
            // Food item on tray
            let food = makeSphere(radius: 0.03, color: c)
            food.position = [-0.2 + Float(i) * 0.2, -0.1, -0.5]
            root.addChild(food)
        }

        // Nutrition poster on wall
        let poster = makeBox(width: 0.3, height: 0.22, depth: 0.012, color: .init(red: 0.4, green: 0.8, blue: 0.4, alpha: 1))
        poster.position = [0.55, 0.0, -0.55]
        root.addChild(poster)

        // Window with curtains
        let window = makeBox(width: 0.28, height: 0.32, depth: 0.015, color: .init(red: 0.85, green: 0.95, blue: 1.0, alpha: 0.9))
        window.position = [-0.6, 0.05, -0.1]
        root.addChild(window)
        let curtainL = makeBox(width: 0.06, height: 0.32, depth: 0.02, color: .init(red: 0.4, green: 0.75, blue: 0.45, alpha: 1))
        curtainL.position = [-0.73, 0.05, -0.1]
        root.addChild(curtainL)
        let curtainR = makeBox(width: 0.06, height: 0.32, depth: 0.02, color: .init(red: 0.4, green: 0.75, blue: 0.45, alpha: 1))
        curtainR.position = [-0.47, 0.05, -0.1]
        root.addChild(curtainR)

        return root
    }

    private static func makeDiningTable() -> Entity {
        let group = Entity()

        // Table top
        let top = makeBox(width: 0.32, height: 0.025, depth: 0.22, color: .init(red: 0.85, green: 0.65, blue: 0.45, alpha: 1))
        top.position = [0, 0, 0]
        group.addChild(top)

        // Table leg (central)
        let leg = makeCylinder(radius: 0.02, height: 0.22, color: .init(red: 0.6, green: 0.45, blue: 0.3, alpha: 1))
        leg.position = [0, -0.12, 0]
        group.addChild(leg)

        // Chairs (4 around table)
        let chairOffsets: [(Float, Float, Float)] = [
            (0, 0.18), (0, -0.18), (0.2, 0), (-0.2, 0)
        ].map { ($0.0, 0, $0.1) }
        for offset in chairOffsets {
            let seat = makeBox(width: 0.1, height: 0.015, depth: 0.1, color: .init(red: 0.95, green: 0.4, blue: 0.4, alpha: 1))
            seat.position = [offset.0, -0.07, offset.2]
            group.addChild(seat)
        }

        // Place settings (plates & cups)
        let placeOffsets: [(Float, Float)] = [(-0.08, -0.06), (0.08, -0.06), (-0.08, 0.06), (0.08, 0.06)]
        for p in placeOffsets {
            let plate = makeCylinder(radius: 0.04, height: 0.006, color: .init(red: 0.98, green: 0.96, blue: 0.94, alpha: 1))
            plate.position = [p.0, 0.016, p.1]
            group.addChild(plate)

            let cup = makeCylinder(radius: 0.018, height: 0.06, color: .init(red: 0.5, green: 0.8, blue: 0.6, alpha: 1))
            cup.position = [p.0 + 0.06, 0.03, p.1]
            group.addChild(cup)
        }

        group.position = [0, -0.22, 0]
        return group
    }
}
