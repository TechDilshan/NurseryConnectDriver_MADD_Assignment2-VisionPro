import Foundation

struct ChildAttendance: Identifiable, Codable, Hashable {
    let id: UUID
    var checkInTime: Date?
    var checkOutTime: Date?
    var currentStatus: AttendanceStatus

    init(
        id: UUID = UUID(),
        checkInTime: Date? = nil,
        checkOutTime: Date? = nil,
        currentStatus: AttendanceStatus
    ) {
        self.id = id
        self.checkInTime = checkInTime
        self.checkOutTime = checkOutTime
        self.currentStatus = currentStatus
    }
}

enum AttendanceStatus: String, Codable, CaseIterable, Hashable {
    case notArrived
    case checkedIn
    case checkedOut

    var title: String {
        switch self {
        case .notArrived:
            return "Not Arrived"
        case .checkedIn:
            return "Checked In"
        case .checkedOut:
            return "Checked Out"
        }
    }
}
