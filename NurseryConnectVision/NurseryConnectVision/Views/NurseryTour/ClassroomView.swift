import SwiftUI
import RealityKit

struct ClassroomView: View {
    var body: some View {
        AreaDetailCard(
            title: "Classroom",
            subtitle: "Early literacy, numeracy & guided activities",
            icon: "studentdesk",
            color: .blue,
            gradient: NurseryArea.classroom.themeGradient
        ) {
            AreaPreviewRealityView(area: .classroom)
        }
    }
}

// MARK: - Classroom Scene Entity

enum ClassroomSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()

        let floor = makeBox(width: 1.4, height: 0.025, depth: 1.4, color: .init(red: 0.95, green: 0.92, blue: 0.85, alpha: 1))
        floor.position = [0, -0.36, 0]
        root.addChild(floor)

        let deskPositions: [(Float, Float)] = [(-0.28, 0.1), (0, 0.1), (0.28, 0.1),
                                                (-0.28, -0.1), (0, -0.1), (0.28, -0.1)]
        for pos in deskPositions {
            let desk = makeDeskGroup()
            desk.position = [pos.0, -0.18, pos.1]
            root.addChild(desk)
        }

        let teacherDesk = makeBox(width: 0.32, height: 0.06, depth: 0.18, color: .init(red: 0.6, green: 0.4, blue: 0.2, alpha: 1))
        teacherDesk.position = [0, -0.2, -0.38]
        root.addChild(teacherDesk)

        let board = makeBox(width: 0.55, height: 0.28, depth: 0.02, color: .init(red: 0.95, green: 0.98, blue: 1.0, alpha: 1))
        board.position = [0, 0.04, -0.55]
        root.addChild(board)

        let boardFrame = makeBox(width: 0.58, height: 0.31, depth: 0.015, color: .init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1))
        boardFrame.position = [0, 0.04, -0.565]
        root.addChild(boardFrame)

        let shelf = makeShelf()
        shelf.position = [0.55, -0.12, 0]
        root.addChild(shelf)

        let bookColors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemYellow]
        for (i, bColor) in bookColors.enumerated() {
            let book = makeBox(width: 0.05, height: 0.1, depth: 0.03, color: bColor.withAlphaComponent(1))
            book.position = [0.55, -0.04 + Float(i / 3) * (-0.13), -0.08 + Float(i % 3) * 0.08]
            root.addChild(book)
        }

        let window = makeBox(width: 0.3, height: 0.35, depth: 0.02, color: .init(red: 0.8, green: 0.95, blue: 1.0, alpha: 0.9))
        window.position = [-0.6, 0.08, 0]
        root.addChild(window)

        let windowFrame = makeBox(width: 0.33, height: 0.38, depth: 0.015, color: .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
        windowFrame.position = [-0.605, 0.08, 0]
        root.addChild(windowFrame)

        let globe = makeSphere(radius: 0.04, color: .init(red: 0.3, green: 0.7, blue: 0.9, alpha: 1))
        globe.position = [0.12, -0.12, -0.38]
        root.addChild(globe)

        return root
    }

    private static func makeDeskGroup() -> Entity {
        let group = Entity()
        let top = makeBox(width: 0.16, height: 0.025, depth: 0.12, color: .init(red: 0.82, green: 0.65, blue: 0.45, alpha: 1))
        top.position = [0, 0, 0]
        group.addChild(top)
        let leg = makeBox(width: 0.01, height: 0.1, depth: 0.01, color: .init(red: 0.5, green: 0.4, blue: 0.3, alpha: 1))
        leg.position = [0, -0.06, 0]
        group.addChild(leg)
        let chair = makeBox(width: 0.1, height: 0.015, depth: 0.1, color: .init(red: 0.3, green: 0.55, blue: 0.9, alpha: 1))
        chair.position = [0, -0.04, 0.1]
        group.addChild(chair)
        return group
    }
}
