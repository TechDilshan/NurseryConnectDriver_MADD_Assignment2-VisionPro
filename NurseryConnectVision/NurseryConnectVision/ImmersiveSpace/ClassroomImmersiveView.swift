import SwiftUI
import RealityKit

struct ClassroomImmersiveView: View {
    var body: some View {
        RealityView { content in
            let classroom = ClassroomEntity.create()
            classroom.position = [0, 0, -1.5]
            content.add(classroom)
        }
    }
}
