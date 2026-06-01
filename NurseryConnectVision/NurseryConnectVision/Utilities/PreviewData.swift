import Foundation

enum PreviewData {

    static let sampleChild = Child(
        fullName: "Emma Johnson",
        preferredName: "Emma",
        age: 4,
        roomName: "Blue Room",
        keyworkerName: "Ms. Harper",
        transportStatus: .inTransit,
        attendance: ChildAttendance(
            checkInTime: Date(),
            checkOutTime: nil,
            currentStatus: .checkedIn
        ),
        meals: MockDataService.shared.sampleMeals(),
        activities: MockDataService.shared.sampleActivities()
    )

    static let sampleParent = Parent(
        fullName: "Sarah Johnson",
        relationship: "Mother",
        email: "sarah@example.com",
        phoneNumber: "0771234567",
        children: [
            sampleChild
        ]
    )

    static let sampleVehicle =
        MockDataService.shared.sampleVehicleStatus()

    static let sampleNotices =
        MockDataService.shared.sampleSafetyNotices()

    static let sampleEvents =
        MockDataService.shared.sampleEvents()

    static let sampleActivities =
        MockDataService.shared.sampleActivities()

    static let sampleTourLocations =
        MockDataService.shared.sampleTourLocations()
}
