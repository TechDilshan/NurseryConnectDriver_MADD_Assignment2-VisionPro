import SwiftUI

struct TourInfoPanel: View {
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: nurseryTourViewModel.selectedArea.systemImage)
                    .font(.largeTitle)
                    .foregroundStyle(.blue)

                Spacer()
            }

            Text(nurseryTourViewModel.selectedAreaTitle)
                .font(.title.bold())

            Text(nurseryTourViewModel.selectedAreaDescription)
                .foregroundStyle(.secondary)

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Spatial UX Purpose")
                    .font(.headline)

                Text("This area is shown as a 3D object so parents can understand the nursery environment before visiting physically.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Childcare Value")
                    .font(.headline)

                Text("The tour improves transparency, parent confidence, and understanding of the childcare setting.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack {
                Button {
                    nurseryTourViewModel.previousArea()
                    immersiveViewModel.previousArea()
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                }

                Button {
                    nurseryTourViewModel.nextArea()
                    immersiveViewModel.nextArea()
                } label: {
                    Label("Next", systemImage: "chevron.right")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
