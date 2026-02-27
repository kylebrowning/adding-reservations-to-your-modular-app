import Foundation
import ReservationsApi

extension ReservationApiModel {
    public var domainModel: Reservation? {
        let formatter = ISO8601DateFormatter()
        guard
            let start = formatter.date(from: startDate),
            let end = formatter.date(from: endDate),
            let status = Status(rawValue: status)
        else {
            return nil
        }
        return Reservation(
            id: id,
            landmarkId: landmarkId,
            startDate: start,
            endDate: end,
            status: status,
            guestCount: guestCount,
            notes: notes
        )
    }
}
