import Foundation

enum DateFormatterHelper {

    static func displayDate(
        _ date: Date?
    ) -> String {

        guard let date else {
            return "Unavailable"
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: date)
    }

    static func displayTime(
        _ date: Date?
    ) -> String {

        guard let date else {
            return "Unavailable"
        }

        let formatter = DateFormatter()
        formatter.timeStyle = .short

        return formatter.string(from: date)
    }

    static func displayDateTime(
        _ date: Date?
    ) -> String {

        guard let date else {
            return "Unavailable"
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        return formatter.string(from: date)
    }
}
