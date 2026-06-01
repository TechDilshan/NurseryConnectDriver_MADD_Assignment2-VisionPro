import SwiftUI
import RealityKit

struct GardenImmersiveView: View {
    var body: some View {
        RealityView { content in
            let garden = GardenEntity.create()
            garden.position = [0, 0, -1.5]
            content.add(garden)
        }
    }
}
