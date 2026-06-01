import Foundation

struct Child: Identifiable, Codable, Hashable {
    let id: UUID
    var fullName: String
    var preferredName: String
    var age: Int
    var roomName: String
    var keyworkerName: String
    var profileImageName: String
    var transportStatus: TransportStatus
    var attendance: ChildAttendance
    var meals: [ChildMeal]
    var activities: [DailyActivity]

    init(
        id: UUID = UUID(),
        fullName: String,
        preferredName: String,
        age: Int,
        roomName: String,
        keyworkerName: String,
        profileImageName: String = "person.crop.circle.fill",
        transportStatus: TransportStatus,
        attendance: ChildAttendance,
        meals: [ChildMeal],
        activities: [DailyActivity]
    ) {
        self.id = id
        self.fullName = fullName
        self.preferredName = preferredName
        self.age = age
        self.roomName = roomName
        self.keyworkerName = keyworkerName
        self.profileImageName = profileImageName
        self.transportStatus = transportStatus
        self.attendance = attendance
        self.meals = meals
        self.activities = activities
    }
}
