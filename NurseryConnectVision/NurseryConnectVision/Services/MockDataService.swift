import Foundation

final class MockDataService {
    static let shared = MockDataService()

    private init() {}

    func sampleParent() -> Parent {
        Parent(
            fullName: "Sarah Johnson",
            relationship: "Mother",
            email: "sarah.johnson@example.com",
            phoneNumber: "0771234567",
            children: sampleChildren()
        )
    }

    func sampleChildren() -> [Child] {
        [
            Child(
                fullName: "Emma Johnson",
                preferredName: "Emma",
                age: 4,
                roomName: "Blue Room",
                keyworkerName: "Ms. Harper",
                transportStatus: .inTransit,
                attendance: ChildAttendance(
                    checkInTime: nil,
                    checkOutTime: nil,
                    currentStatus: .notArrived
                ),
                meals: sampleMeals(),
                activities: sampleActivities()
            ),
            Child(
                fullName: "Liam Smith",
                preferredName: "Liam",
                age: 5,
                roomName: "Green Room",
                keyworkerName: "Mr. Lewis",
                transportStatus: .arrivedAtNursery,
                attendance: ChildAttendance(
                    checkInTime: Date(),
                    checkOutTime: nil,
                    currentStatus: .checkedIn
                ),
                meals: sampleMeals(),
                activities: sampleActivities()
            )
        ]
    }

    func sampleMeals() -> [ChildMeal] {
        [
            ChildMeal(
                mealType: .breakfast,
                foodDescription: "Porridge with banana",
                portionConsumed: .most,
                notes: "Ate well"
            ),
            ChildMeal(
                mealType: .lunch,
                foodDescription: "Pasta with vegetables",
                portionConsumed: .half,
                notes: "Preferred vegetables"
            )
        ]
    }

    func sampleActivities() -> [DailyActivity] {
        [
            DailyActivity(
                title: "Story Time",
                description: "Joined group reading and answered questions.",
                area: .readingCorner,
                eyfsArea: "Communication and Language"
            ),
            DailyActivity(
                title: "Outdoor Play",
                description: "Played safely with peers in the garden.",
                area: .outdoorGarden,
                eyfsArea: "Physical Development"
            ),
            DailyActivity(
                title: "Creative Painting",
                description: "Used colours and shapes to complete a painting task.",
                area: .classroom,
                eyfsArea: "Expressive Arts and Design"
            )
        ]
    }

    func sampleEvents() -> [NurseryEvent] {
        [
            NurseryEvent(
                title: "Parent Open Morning",
                description: "A guided parent visit through classroom and play areas.",
                area: .classroom
            ),
            NurseryEvent(
                title: "Garden Play Session",
                description: "Outdoor activities focused on movement and social skills.",
                area: .outdoorGarden
            )
        ]
    }

    func sampleSafetyNotices() -> [SafetyNotice] {
        [
            SafetyNotice(
                title: "Safeguarding Policy",
                message: "All children are supervised by assigned staff and safeguarding concerns are escalated to the Designated Safeguarding Lead.",
                category: .safeguarding,
                priority: .high
            ),
            SafetyNotice(
                title: "Transport Monitoring",
                message: "Children are tracked during school pickup using secure transport status updates.",
                category: .transport,
                priority: .medium
            ),
            SafetyNotice(
                title: "Health and Allergy Awareness",
                message: "Meal records and allergy requirements are reviewed before food service.",
                category: .health,
                priority: .medium
            )
        ]
    }

    func sampleTourLocations() -> [TourLocation] {
        [
            TourLocation(
                area: .classroom,
                title: "Classroom",
                description: NurseryArea.classroom.description,
                assetName: NurseryArea.classroom.assetName,
                xPosition: -0.8,
                yPosition: 0,
                zPosition: -1.5
            ),
            TourLocation(
                area: .playArea,
                title: "Play Area",
                description: NurseryArea.playArea.description,
                assetName: NurseryArea.playArea.assetName,
                xPosition: 0.8,
                yPosition: 0,
                zPosition: -1.5
            ),
            TourLocation(
                area: .diningArea,
                title: "Dining Area",
                description: NurseryArea.diningArea.description,
                assetName: NurseryArea.diningArea.assetName,
                xPosition: -0.8,
                yPosition: 0,
                zPosition: -2.5
            ),
            TourLocation(
                area: .outdoorGarden,
                title: "Outdoor Garden",
                description: NurseryArea.outdoorGarden.description,
                assetName: NurseryArea.outdoorGarden.assetName,
                xPosition: 0.8,
                yPosition: 0,
                zPosition: -2.5
            )
        ]
    }

    func sampleVehicleStatus() -> VehicleStatus {
        VehicleStatus(
            vehicleNumber: "NCD-1024",
            driverName: "Driver",
            currentLocationDescription: "Near Little Stars Preschool",
            estimatedArrivalMinutes: 8,
            childrenOnBoard: 3,
            totalChildren: 4,
            routeProgress: 0.65,
            isActive: true
        )
    }
}
