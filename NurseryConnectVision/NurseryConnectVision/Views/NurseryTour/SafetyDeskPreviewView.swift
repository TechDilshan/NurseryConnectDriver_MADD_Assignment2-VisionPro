import SwiftUI
import RealityKit

struct SafetyDeskPreviewView: View {
    var body: some View {
        AreaDetailCard(
            title: "Safety Desk",
            subtitle: "Central safeguarding hub — DBS checked, Ofsted compliant",
            icon: "shield.lefthalf.filled",
            color: .red,
            gradient: NurseryArea.safetyDesk.themeGradient
        ) {
            AreaPreviewRealityView(area: .safetyDesk)
        }
    }
}

// MARK: - Safety Desk Scene

enum SafetyDeskSceneEntity {
    static func buildScene() -> Entity {
        let root = Entity()
        root.position = [0, 0.0, -0.5]

        // Floor (professional grey)
        let floor = makeBox(width: 1.4, height: 0.025, depth: 1.4, color: .init(red: 0.72, green: 0.72, blue: 0.75, alpha: 1))
        floor.position = [0, -0.36, 0]
        root.addChild(floor)

        // Main reception desk (L-shape)
        let deskMain = makeBox(width: 0.7, height: 0.14, depth: 0.22, color: .init(red: 0.25, green: 0.3, blue: 0.42, alpha: 1))
        deskMain.position = [0, -0.22, -0.25]
        root.addChild(deskMain)

        let deskSide = makeBox(width: 0.22, height: 0.14, depth: 0.35, color: .init(red: 0.25, green: 0.3, blue: 0.42, alpha: 1))
        deskSide.position = [0.38, -0.22, -0.08]
        root.addChild(deskSide)

        let deskTop = makeBox(width: 0.72, height: 0.012, depth: 0.24, color: .init(red: 0.88, green: 0.88, blue: 0.9, alpha: 1))
        deskTop.position = [0, -0.15, -0.25]
        root.addChild(deskTop)

        let deskSideTop = makeBox(width: 0.24, height: 0.012, depth: 0.37, color: .init(red: 0.88, green: 0.88, blue: 0.9, alpha: 1))
        deskSideTop.position = [0.38, -0.15, -0.08]
        root.addChild(deskSideTop)

        // Computer monitor
        let monitor = makeBox(width: 0.2, height: 0.15, depth: 0.015, color: .init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))
        monitor.position = [-0.1, -0.07, -0.25]
        root.addChild(monitor)

        // Monitor screen (glowing blue)
        let screen = makeBox(width: 0.18, height: 0.13, depth: 0.016, color: .init(red: 0.15, green: 0.45, blue: 0.85, alpha: 1))
        screen.position = [-0.1, -0.07, -0.246]
        root.addChild(screen)

        // CCTV monitor bank (wall)
        for i in 0..<4 {
            let cctv = makeBox(width: 0.1, height: 0.08, depth: 0.012, color: .init(red: 0.05, green: 0.05, blue: 0.08, alpha: 1))
            cctv.position = [-0.22 + Float(i) * 0.16, 0.06, -0.58]
            root.addChild(cctv)

            let cctvScreen = makeBox(width: 0.09, height: 0.07, depth: 0.013, color: .init(red: 0.1, green: 0.35, blue: 0.2, alpha: 1))
            cctvScreen.position = [-0.22 + Float(i) * 0.16, 0.06, -0.576]
            root.addChild(cctvScreen)
        }

        // Wall label "CCTV"
        let cctvBar = makeBox(width: 0.7, height: 0.02, depth: 0.01, color: .init(red: 0.9, green: 0.2, blue: 0.2, alpha: 1))
        cctvBar.position = [0.02, 0.15, -0.58]
        root.addChild(cctvBar)

        // First aid box (wall mounted)
        let aidBox = makeBox(width: 0.1, height: 0.08, depth: 0.04, color: .init(red: 0.9, green: 0.15, blue: 0.15, alpha: 1))
        aidBox.position = [0.52, 0.0, -0.56]
        root.addChild(aidBox)

        let aidCross1 = makeBox(width: 0.07, height: 0.018, depth: 0.042, color: .init(red: 1, green: 1, blue: 1, alpha: 1))
        aidCross1.position = [0.52, 0.0, -0.537]
        root.addChild(aidCross1)

        let aidCross2 = makeBox(width: 0.018, height: 0.07, depth: 0.042, color: .init(red: 1, green: 1, blue: 1, alpha: 1))
        aidCross2.position = [0.52, 0.0, -0.537]
        root.addChild(aidCross2)

        // Sign-in clipboard on desk
        let clipboard = makeBox(width: 0.08, height: 0.1, depth: 0.008, color: .init(red: 0.95, green: 0.92, blue: 0.86, alpha: 1))
        clipboard.position = [0.12, -0.14, -0.25]
        root.addChild(clipboard)

        // Visitor badge rack
        let badgeRack = makeBox(width: 0.12, height: 0.08, depth: 0.05, color: .init(red: 0.8, green: 0.7, blue: 0.5, alpha: 1))
        badgeRack.position = [0.28, -0.14, -0.25]
        root.addChild(badgeRack)

        // Chair for officer
        let chairSeat = makeBox(width: 0.18, height: 0.015, depth: 0.18, color: .init(red: 0.15, green: 0.25, blue: 0.5, alpha: 1))
        chairSeat.position = [0, -0.2, 0.12]
        root.addChild(chairSeat)

        let chairBack = makeBox(width: 0.18, height: 0.22, depth: 0.015, color: .init(red: 0.15, green: 0.25, blue: 0.5, alpha: 1))
        chairBack.position = [0, -0.1, 0.03]
        root.addChild(chairBack)

        return root
    }
}
