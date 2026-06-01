import SwiftUI
import RealityKit

struct DiningImmersiveView: View {
    var body: some View {
        RealityView { content in
            let dining = DiningEntity.create()
            dining.position = [0, 0, -1.5]
            content.add(dining)
        }
    }
}
