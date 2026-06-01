import SwiftUI

@main
struct NurseryConnectVisionApp: App {

    @StateObject private var parentDashboardViewModel =
        ParentDashboardViewModel()

    @StateObject private var transportViewModel =
        TransportViewModel()

    @StateObject private var nurseryTourViewModel =
        NurseryTourViewModel()

    @StateObject private var safetyViewModel =
        SafetyViewModel()

    @StateObject private var immersiveViewModel =
        ImmersiveViewModel()

    var body: some Scene {

        WindowGroup(
            id: AppConstants.mainWindowID
        ) {

            MainWindowView()
                .environmentObject(parentDashboardViewModel)
                .environmentObject(transportViewModel)
                .environmentObject(nurseryTourViewModel)
                .environmentObject(safetyViewModel)
                .environmentObject(immersiveViewModel)
        }

        WindowGroup(
            id: AppConstants.transportWindowID
        ) {

            TransportTrackingView()
                .environmentObject(transportViewModel)
        }

        WindowGroup(
            id: AppConstants.safetyWindowID
        ) {

            SafetyDashboardView()
                .environmentObject(safetyViewModel)
        }

        WindowGroup(
            id: AppConstants.tourWindowID
        ) {

            NurseryTourView()
                .environmentObject(nurseryTourViewModel)
        }

        ImmersiveSpace(
            id: AppConstants.immersiveSpaceID
        ) {

            NurseryImmersiveView()
                .environmentObject(immersiveViewModel)
        }
    }
}
