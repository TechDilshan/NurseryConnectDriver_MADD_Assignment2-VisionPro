import Foundation

struct NurseryEvent: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var eventDate: Date
    var area: NurseryArea

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        eventDate: Date = Date(),
        area: NurseryArea
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.eventDate = eventDate
        self.area = area
    }
}
