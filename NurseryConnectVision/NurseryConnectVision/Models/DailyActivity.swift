import Foundation

struct DailyActivity: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var area: NurseryArea
    var time: Date
    var eyfsArea: String

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        area: NurseryArea,
        time: Date = Date(),
        eyfsArea: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.area = area
        self.time = time
        self.eyfsArea = eyfsArea
    }
}
