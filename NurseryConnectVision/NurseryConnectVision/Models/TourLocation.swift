import Foundation

struct TourLocation: Identifiable, Codable, Hashable {
    let id: UUID
    var area: NurseryArea
    var title: String
    var description: String
    var assetName: String
    var xPosition: Float
    var yPosition: Float
    var zPosition: Float

    init(
        id: UUID = UUID(),
        area: NurseryArea,
        title: String,
        description: String,
        assetName: String,
        xPosition: Float,
        yPosition: Float,
        zPosition: Float
    ) {
        self.id = id
        self.area = area
        self.title = title
        self.description = description
        self.assetName = assetName
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.zPosition = zPosition
    }
}
