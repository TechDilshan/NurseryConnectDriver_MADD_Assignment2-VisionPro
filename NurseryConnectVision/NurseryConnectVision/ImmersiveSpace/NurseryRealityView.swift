import SwiftUI
import RealityKit

struct NurseryRealityView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        RealityView { content in
            content.add(NurseryAreaSceneFactory.buildImmersive(for: immersiveViewModel.selectedArea))
        } update: { content in
            content.entities.removeAll()
            content.add(NurseryAreaSceneFactory.buildImmersive(for: immersiveViewModel.selectedArea))
        }
    }
}
