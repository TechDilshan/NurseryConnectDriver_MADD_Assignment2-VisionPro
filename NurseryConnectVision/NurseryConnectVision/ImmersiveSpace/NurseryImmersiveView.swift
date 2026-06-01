import SwiftUI
import RealityKit

struct NurseryImmersiveView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        NurseryRealityView()
            .environmentObject(immersiveViewModel)
            .ornament(visibility: .visible, attachmentAnchor: .scene(.top), contentAlignment: .top) {
                ImmersiveTopNavigationBar()
                    .environmentObject(immersiveViewModel)
            }
            .persistentSystemOverlays(.hidden)
            .onAppear {
                immersiveViewModel.markImmersiveSpaceOpened()
            }
            .onDisappear {
                immersiveViewModel.markImmersiveSpaceClosed()
            }
    }
}
