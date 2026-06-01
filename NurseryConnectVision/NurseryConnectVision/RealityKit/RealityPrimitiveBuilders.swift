import RealityKit
import UIKit

// MARK: - Tour preview primitive builders (SimpleMaterial — visible in window previews)

private func previewMaterial(color: UIColor) -> SimpleMaterial {
    SimpleMaterial(color: color, isMetallic: false)
}

func makeBox(width: Float, height: Float, depth: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateBox(width: width, height: height, depth: depth, cornerRadius: 0.008)
    return ModelEntity(mesh: mesh, materials: [previewMaterial(color: color)])
}

func makeSphere(radius: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateSphere(radius: radius)
    return ModelEntity(mesh: mesh, materials: [previewMaterial(color: color)])
}

func makeMesh(_ resource: MeshResource, color: UIColor) -> ModelEntity {
    ModelEntity(mesh: resource, materials: [previewMaterial(color: color)])
}

func makeCylinder(radius: Float, height: Float, color: UIColor) -> ModelEntity {
    let mesh = MeshResource.generateCylinder(height: height, radius: radius)
    return ModelEntity(mesh: mesh, materials: [previewMaterial(color: color)])
}

func makeShelf() -> Entity {
    let shelf = Entity()
    let body = makeBox(width: 0.08, height: 0.3, depth: 0.12, color: .init(red: 0.6, green: 0.45, blue: 0.3, alpha: 1))
    shelf.addChild(body)
    for i in 0..<3 {
        let plank = makeBox(width: 0.08, height: 0.01, depth: 0.12, color: .init(red: 0.7, green: 0.55, blue: 0.38, alpha: 1))
        plank.position = [0, -0.08 + Float(i) * 0.1, 0]
        shelf.addChild(plank)
    }
    return shelf
}
