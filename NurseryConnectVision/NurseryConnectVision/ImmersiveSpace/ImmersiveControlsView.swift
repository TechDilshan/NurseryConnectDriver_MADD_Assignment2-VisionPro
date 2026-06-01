import SwiftUI

struct ImmersiveControlsView: View {
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        VStack(spacing: 14) {
            Text(immersiveViewModel.selectedAreaTitle)
                .font(.title.bold())

            Text(immersiveViewModel.selectedAreaDescription)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 600)

            HStack(spacing: 14) {
                Button {
                    immersiveViewModel.previousArea()
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                }

                Menu {
                    ForEach(NurseryArea.allCases) { area in
                        Button {
                            immersiveViewModel.selectArea(area)
                        } label: {
                            Label(area.title, systemImage: area.systemImage)
                        }
                    }
                } label: {
                    Label("Select Area", systemImage: "square.grid.2x2.fill")
                }

                Button {
                    immersiveViewModel.nextArea()
                } label: {
                    Label("Next", systemImage: "chevron.right")
                }
            }
            .buttonStyle(.borderedProminent)

            Text(immersiveViewModel.statusMessage)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
