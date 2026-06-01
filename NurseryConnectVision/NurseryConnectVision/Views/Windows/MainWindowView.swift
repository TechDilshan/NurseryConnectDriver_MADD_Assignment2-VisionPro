import SwiftUI

struct MainWindowView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel
    @EnvironmentObject var nurseryTourViewModel: NurseryTourViewModel
    @EnvironmentObject var immersiveViewModel: ImmersiveViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        NavigationSplitView {
            sidebar
        } detail: {
            selectedView
        }
        .navigationTitle(AppConstants.appName)
    }

    private var sidebar: some View {
        List {
            Section("NurseryConnect Vision") {
                ForEach(AppRoute.allCases, id: \.self) { route in
                    Button {
                        parentDashboardViewModel.selectRoute(route)
                    } label: {
                        Label(route.title, systemImage: icon(for: route))
                    }
                    .listRowBackground(
                        parentDashboardViewModel.selectedPrototypePurpose == nil
                            && parentDashboardViewModel.selectedRoute == route
                            ? Color.accentColor.opacity(0.15)
                            : nil
                    )
                }
            }

            Section("Prototype Purpose") {
                ForEach(PrototypePurpose.allCases) { purpose in
                    Button {
                        parentDashboardViewModel.selectPrototypePurpose(purpose)
                    } label: {
                        Label(purpose.title, systemImage: purpose.systemImage)
                    }
                    .listRowBackground(
                        parentDashboardViewModel.selectedPrototypePurpose == purpose
                            ? Color.accentColor.opacity(0.15)
                            : nil
                    )
                }
            }
        }
        .navigationTitle("Vision Menu")
        .frame(minWidth: 260)
    }

    @ViewBuilder
    private var selectedView: some View {
        if let purpose = parentDashboardViewModel.selectedPrototypePurpose {
            prototypeView(for: purpose)
        } else {
            switch parentDashboardViewModel.selectedRoute {
            case .dashboard:
                ParentWindowView()
            case .nurseryTour:
                TourWindowView()
            case .transport:
                TransportTrackingView()
            case .safety:
                SafetyWindowView()
            }
        }
    }

    @ViewBuilder
    private func prototypeView(for purpose: PrototypePurpose) -> some View {
        switch purpose {
        case .parentRole:
            ParentRolePrototypeView()
                .environmentObject(parentDashboardViewModel)
                .environmentObject(transportViewModel)
        case .spatialTour:
            SpatialTourPrototypeView()
                .environmentObject(parentDashboardViewModel)
                .environmentObject(nurseryTourViewModel)
                .environmentObject(immersiveViewModel)
        case .transportExtension:
            TransportExtensionPrototypeView()
                .environmentObject(parentDashboardViewModel)
                .environmentObject(transportViewModel)
        }
    }

    private func icon(for route: AppRoute) -> String {
        switch route {
        case .dashboard: return "rectangle.grid.2x2.fill"
        case .nurseryTour: return "cube.transparent.fill"
        case .transport: return "bus.fill"
        case .safety: return "shield.lefthalf.filled"
        }
    }
}
