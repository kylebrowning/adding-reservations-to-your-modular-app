import Foundation

extension Reservation {
    public static let mocks: [Reservation] = [
        Reservation(
            id: 2001,
            landmarkId: 1001,
            startDate: ISO8601DateFormatter().date(from: "2026-03-15T00:00:00Z")!,
            endDate: ISO8601DateFormatter().date(from: "2026-03-18T00:00:00Z")!,
            status: .confirmed,
            guestCount: 2,
            notes: "Anniversary trip"
        ),
        Reservation(
            id: 2002,
            landmarkId: 1002,
            startDate: ISO8601DateFormatter().date(from: "2026-04-01T00:00:00Z")!,
            endDate: ISO8601DateFormatter().date(from: "2026-04-05T00:00:00Z")!,
            status: .pending,
            guestCount: 4,
            notes: nil
        ),
        Reservation(
            id: 2003,
            landmarkId: 1004,
            startDate: ISO8601DateFormatter().date(from: "2026-05-10T00:00:00Z")!,
            endDate: ISO8601DateFormatter().date(from: "2026-05-12T00:00:00Z")!,
            status: .cancelled,
            guestCount: 1,
            notes: "Weather concerns"
        ),
    ]
}
