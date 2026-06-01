import SwiftUI

struct MainWindowView: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel

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
                        parentDashboardViewModel.selectedRoute = route
                    } label: {
                        Label(route.title, systemImage: icon(for: route))
                    }
                }
            }

            Section("Prototype Purpose") {
                Label("Parent Role", systemImage: "person.2.fill")
                Label("Spatial Tour", systemImage: "visionpro")
                Label("Transport Extension", systemImage: "bus.fill")
            }
        }
        .navigationTitle("Vision Menu")
        .frame(minWidth: 260)
    }

    @ViewBuilder
    private var selectedView: some View {
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

    private func icon(for route: AppRoute) -> String {
        switch route {
        case .dashboard:
            return "rectangle.grid.2x2.fill"
        case .nurseryTour:
            return "cube.transparent.fill"
        case .transport:
            return "bus.fill"
        case .safety:
            return "shield.lefthalf.filled"
        }
    }
}
