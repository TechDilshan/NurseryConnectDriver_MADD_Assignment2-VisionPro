import SwiftUI

struct TransportExtensionPrototypeView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        PrototypePurposeScreen(
            purpose: .transportExtension,
            headline: "Driver app companion for parents",
            summary: "This Vision Pro extension mirrors transport data from the NurseryConnect Driver app—vehicle location, route progress, ETA, and on-board children—so parents know when pickup or drop-off is approaching.",
            onOpenFeature: { parentDashboardViewModel.openLinkedFeature(for: .transportExtension) }
        ) {
            HStack(spacing: 16) {
                PrototypeMetricPill(
                    label: "Vehicle",
                    value: transportViewModel.vehicleNumberText,
                    icon: "bus.fill",
                    color: .orange
                )
                PrototypeMetricPill(
                    label: "ETA",
                    value: transportViewModel.etaText,
                    icon: "clock.fill",
                    color: .blue
                )
                PrototypeMetricPill(
                    label: "On board",
                    value: transportViewModel.childrenOnBoardText,
                    icon: "person.2.fill",
                    color: .green
                )
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeaderView(
                        title: "Extension capabilities",
                        subtitle: "Links parent dashboard to driver operations"
                    )

                    PrototypeFeatureRow(
                        icon: "location.fill",
                        title: "Live route progress",
                        detail: "Visual progress bar shows how far the nursery bus is along today’s route.",
                        color: .orange
                    )
                    PrototypeFeatureRow(
                        icon: "person.fill.questionmark",
                        title: "Driver information",
                        detail: "Parents see assigned driver name and vehicle details for reassurance.",
                        color: .blue
                    )
                    PrototypeFeatureRow(
                        icon: "arrow.triangle.branch",
                        title: "Separate driver app",
                        detail: "Driver workflows stay in NurseryConnect Driver; this app only consumes parent-safe status.",
                        color: .purple
                    )
                    PrototypeFeatureRow(
                        icon: "calendar.badge.clock",
                        title: "Arrival estimates",
                        detail: "ETA updates help parents time collection without calling the nursery.",
                        color: .teal
                    )
                }
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeaderView(
                        title: "Current transport status",
                        subtitle: "Mock data for prototype demo"
                    )

                    HStack {
                        Label(transportViewModel.trackingStatusTitle, systemImage: "bus.doubledecker.fill")
                            .font(.headline)
                        Spacer()
                        Text(transportViewModel.vehicleStatus.currentLocationDescription)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    RouteProgressView()
                        .environmentObject(transportViewModel)

                    Label("Driver: \(transportViewModel.driverNameText)", systemImage: "person.crop.circle")
                        .foregroundStyle(.secondary)
                }
            }

            GlassCardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Architecture note")
                        .font(.headline)
                    Text("NurseryConnect Vision is the parent spatial layer. NurseryConnect Driver handles routes, attendance on the bus, and staff actions. Both share child identity in a future production backend.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
