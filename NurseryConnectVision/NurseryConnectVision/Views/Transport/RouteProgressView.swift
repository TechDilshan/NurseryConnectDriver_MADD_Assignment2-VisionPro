import SwiftUI
import RealityKit

struct RouteProgressView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("3D Route Progress")
                        .font(.title2.bold())

                    Text("A spatial-style progress preview showing the vehicle journey towards the nursery.")
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(transportViewModel.routeProgressText)
                    .font(.title.bold())
                    .foregroundStyle(.blue)
            }

            ProgressView(value: transportViewModel.vehicleStatus.routeProgress)
                .progressViewStyle(.linear)

            RealityView { content in
                let route = createRouteEntity()
                content.add(route)
            } update: { content in
                guard let root = content.entities.first else { return }

                if let vehicle = root.findEntity(named: "RouteVehicle") {
                    let progress = Float(transportViewModel.vehicleStatus.routeProgress)
                    vehicle.position.x = -0.75 + (progress * 1.5)
                }
            }
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 24))

            HStack {
                Label("School Pickup", systemImage: "building.2.fill")
                Spacer()
                Label("Little Stars Nursery", systemImage: "house.fill")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }

    private func createRouteEntity() -> Entity {
        let root = Entity()

        let road = ModelEntity(
            mesh: .generateBox(width: 1.8, height: 0.035, depth: 0.12),
            materials: [
                SimpleMaterial(color: .darkGray, roughness: 0.7, isMetallic: false)
            ]
        )
        road.position = [0, 0, -0.3]
        root.addChild(road)

        let start = ModelEntity(
            mesh: .generateSphere(radius: 0.08),
            materials: [
                SimpleMaterial(color: .systemOrange, roughness: 0.5, isMetallic: false)
            ]
        )
        start.position = [-0.85, 0.08, -0.3]
        root.addChild(start)

        let end = ModelEntity(
            mesh: .generateSphere(radius: 0.08),
            materials: [
                SimpleMaterial(color: .systemGreen, roughness: 0.5, isMetallic: false)
            ]
        )
        end.position = [0.85, 0.08, -0.3]
        root.addChild(end)

        let vehicle = ModelEntity(
            mesh: .generateBox(width: 0.18, height: 0.12, depth: 0.12),
            materials: [
                SimpleMaterial(color: .systemBlue, roughness: 0.5, isMetallic: false)
            ]
        )
        vehicle.name = "RouteVehicle"
        vehicle.position = [-0.75, 0.13, -0.3]
        root.addChild(vehicle)

        let label = NurseryEntity.makeTextPanel(
            text: "Live Transport Route",
            width: 1.2,
            height: 0.18,
            color: .systemBlue
        )
        label.position = [0, 0.42, -0.3]
        root.addChild(label)

        return root
    }
}
