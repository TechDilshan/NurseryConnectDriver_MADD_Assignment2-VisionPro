import SwiftUI

// MARK: - Shared prototype layout

struct PrototypePurposeScreen<Content: View>: View {
    let purpose: PrototypePurpose
    let headline: String
    let summary: String
    let onOpenFeature: () -> Void
    @ViewBuilder let content: () -> Content

    private var accent: Color {
        switch purpose {
        case .parentRole: return .blue
        case .spatialTour: return .purple
        case .transportExtension: return .orange
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                summaryCard
                content()
                openFeatureButton
            }
            .padding(32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            LinearGradient(
                colors: [accent.opacity(0.14), Color.clear],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(accent.opacity(0.2))
                    .frame(width: 64, height: 64)
                Image(systemName: purpose.systemImage)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(accent)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Prototype Purpose")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(purpose.title)
                    .font(.largeTitle.bold())
                Text(headline)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var summaryCard: some View {
        GlassCardView {
            VStack(alignment: .leading, spacing: 12) {
                Label("Assignment focus", systemImage: "doc.text.fill")
                    .font(.headline)
                    .foregroundStyle(accent)
                Text(summary)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var openFeatureButton: some View {
        Button(action: onOpenFeature) {
            HStack {
                Image(systemName: "arrow.right.circle.fill")
                Text("Open \(purpose.linkedRoute.title)")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
        }
        .buttonStyle(.borderedProminent)
        .tint(accent)
    }
}

struct PrototypeFeatureRow: View {
    let icon: String
    let title: String
    let detail: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct PrototypeMetricPill: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(value)
                .font(.title2.bold())
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
