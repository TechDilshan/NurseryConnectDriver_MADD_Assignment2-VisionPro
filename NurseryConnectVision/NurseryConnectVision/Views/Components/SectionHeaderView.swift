import SwiftUI

struct SectionHeaderView: View {

    let title: String
    let subtitle: String

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text(title)
                .font(.title.bold())

            Text(subtitle)
                .foregroundStyle(.secondary)
        }
    }
}
