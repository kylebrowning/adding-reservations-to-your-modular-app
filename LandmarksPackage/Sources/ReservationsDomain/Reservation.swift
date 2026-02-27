import Foundation
import LandmarksDomain

public struct Reservation: DomainModel, Identifiable {
    public let id: Int
    public let landmarkId: Int
    public let startDate: Date
    public let endDate: Date
    public let status: Status
    public let guestCount: Int
    public let notes: String?

    public init(
        id: Int,
        landmarkId: Int,
        startDate: Date,
        endDate: Date,
        status: Status,
        guestCount: Int,
        notes: String?
    ) {
        self.id = id
        self.landmarkId = landmarkId
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.guestCount = guestCount
        self.notes = notes
    }
}

public enum Status: String, CaseIterable, Sendable {
    case pending = "pending"
    case confirmed = "confirmed"
    case cancelled = "cancelled"
}
