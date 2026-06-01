import SwiftUI

struct SpatialButton: View {

    let title: String
    let systemImage: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Label(title, systemImage: systemImage)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}
