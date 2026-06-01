import SwiftUI
import RealityKit

struct PlayAreaImmersiveView: View {
    var body: some View {
        RealityView { content in
            let playground = PlaygroundEntity.create()
            playground.position = [0, 0, -1.5]
            content.add(playground)
        }
    }
}
