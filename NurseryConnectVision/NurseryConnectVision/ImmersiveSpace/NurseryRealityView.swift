import SwiftUI
import RealityKit

struct NurseryRealityView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        RealityView { content in
            content.add(buildImmersiveWorld(for: immersiveViewModel.selectedArea))
        } update: { content in
            content.entities.removeAll()
            content.add(buildImmersiveWorld(for: immersiveViewModel.selectedArea))
        }
        .id(immersiveViewModel.selectedArea)
    }

    private func buildImmersiveWorld(for area: NurseryArea) -> Entity {
        let world = Entity()
        world.name = "NurseryImmersiveWorld"

        world.addChild(ImmersiveNurseryEnvironment.build(for: area))

        let sceneAnchor = Entity()
        sceneAnchor.position = [0, 0, -2.5]
        sceneAnchor.addChild(ImmersiveAreaScenes.build(for: area))
        world.addChild(sceneAnchor)

        return world
    }
}
