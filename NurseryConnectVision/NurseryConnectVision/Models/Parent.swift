import Foundation

struct Parent: Identifiable, Codable, Hashable {
    let id: UUID
    var fullName: String
    var relationship: String
    var email: String
    var phoneNumber: String
    var children: [Child]

    init(
        id: UUID = UUID(),
        fullName: String,
        relationship: String,
        email: String,
        phoneNumber: String,
        children: [Child]
    ) {
        self.id = id
        self.fullName = fullName
        self.relationship = relationship
        self.email = email
        self.phoneNumber = phoneNumber
        self.children = children
    }
}
