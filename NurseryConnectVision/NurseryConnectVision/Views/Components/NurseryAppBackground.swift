import SwiftUI

/// Visual style for the custom window backdrop (replaces simulator passthrough).
enum NurseryBackgroundStyle {
    case dashboard
    case tour
    case transport
    case safety
    case prototype
}

/// Full-window nursery environment for visionOS volumes — opaque enough to hide the default simulator room.
struct NurseryAppBackground: View {
    var style: NurseryBackgroundStyle = .dashboard

    var body: some View {
        ZStack {
            baseGradient
            groundBand
            decorativeShapes
            cloudLayer
            brandingOverlay
        }
        .ignoresSafeArea()
    }

    private var baseGradient: some View {
        LinearGradient(
            colors: gradientColors,
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var gradientColors: [Color] {
        switch style {
        case .dashboard:
            return [
                Color(red: 0.72, green: 0.86, blue: 0.98),
                Color(red: 0.85, green: 0.93, blue: 0.88),
                Color(red: 0.78, green: 0.9, blue: 0.82)
            ]
        case .tour:
            return [
                Color(red: 0.68, green: 0.88, blue: 0.95),
                Color(red: 0.82, green: 0.95, blue: 0.85),
                Color(red: 0.75, green: 0.88, blue: 0.78)
            ]
        case .transport:
            return [
                Color(red: 0.98, green: 0.9, blue: 0.78),
                Color(red: 0.88, green: 0.92, blue: 0.98),
                Color(red: 0.82, green: 0.88, blue: 0.94)
            ]
        case .safety:
            return [
                Color(red: 0.95, green: 0.88, blue: 0.88),
                Color(red: 0.88, green: 0.92, blue: 0.98),
                Color(red: 0.9, green: 0.94, blue: 0.96)
            ]
        case .prototype:
            return [
                Color(red: 0.78, green: 0.82, blue: 0.98),
                Color(red: 0.9, green: 0.88, blue: 0.95),
                Color(red: 0.85, green: 0.92, blue: 0.9)
            ]
        }
    }

    private var groundBand: some View {
        VStack {
            Spacer()
            LinearGradient(
                colors: [
                    Color(red: 0.35, green: 0.62, blue: 0.32).opacity(0.55),
                    Color(red: 0.28, green: 0.52, blue: 0.26).opacity(0.75)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 180)
        }
    }

    private var decorativeShapes: some View {
        ZStack {
            Circle()
                .fill(accentColor.opacity(0.12))
                .frame(width: 420, height: 420)
                .offset(x: -280, y: -120)
                .blur(radius: 2)

            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 300, height: 300)
                .offset(x: 320, y: 80)

            RoundedRectangle(cornerRadius: 40)
                .fill(accentColor.opacity(0.08))
                .frame(width: 500, height: 120)
                .offset(y: -200)
                .rotationEffect(.degrees(-8))
        }
    }

    private var cloudLayer: some View {
        ZStack {
            cloudBlob.offset(x: -200, y: -280)
            cloudBlob.offset(x: 120, y: -320)
            cloudBlob.scaleEffect(0.8).offset(x: 280, y: -240)
        }
    }

    private var cloudBlob: some View {
        ZStack {
            Circle().fill(Color.white.opacity(0.45)).frame(width: 70, height: 70)
            Circle().fill(Color.white.opacity(0.4)).frame(width: 55, height: 55).offset(x: 35, y: 8)
            Circle().fill(Color.white.opacity(0.38)).frame(width: 48, height: 48).offset(x: -30, y: 12)
        }
    }

    private var brandingOverlay: some View {
        VStack {
            HStack {
                Image(systemName: "building.2.fill")
                    .font(.title3)
                    .foregroundStyle(accentColor.opacity(0.7))
                Text(Constants.nurseryName)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary.opacity(0.9))
                Spacer()
                Image(systemName: "leaf.fill")
                    .foregroundStyle(Color.green.opacity(0.5))
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
            Spacer()
            HStack {
                Label("NurseryConnect Vision", systemImage: "visionpro")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                Spacer()
                Text(styleLabel)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 14)
        }
    }

    private var accentColor: Color {
        switch style {
        case .dashboard: return .blue
        case .tour: return .green
        case .transport: return .orange
        case .safety: return .red
        case .prototype: return .purple
        }
    }

    private var styleLabel: String {
        switch style {
        case .dashboard: return "Parent Dashboard"
        case .tour: return "Spatial Tour"
        case .transport: return "Transport"
        case .safety: return "Safety"
        case .prototype: return "Prototype"
        }
    }
}

// MARK: - View modifier

extension View {
    /// Places the nursery backdrop behind window content so the simulator default room is not visible.
    func nurseryWindowBackground(_ style: NurseryBackgroundStyle = .dashboard) -> some View {
        ZStack {
            NurseryAppBackground(style: style)
            self
        }
    }
}
