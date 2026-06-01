import SwiftUI
import RealityKit

struct NurseryImmersiveView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        ZStack {
            NurseryRealityView()
                .environmentObject(immersiveViewModel)

            VStack {
                Spacer()

                ImmersiveControlsView()
                    .environmentObject(immersiveViewModel)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            immersiveViewModel.markImmersiveSpaceOpened()
        }
        .onDisappear {
            immersiveViewModel.markImmersiveSpaceClosed()
        }
    }
}
