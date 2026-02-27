import Testing
@testable import ReservationsApi
@testable import ReservationsDomain

@Suite("Reservation API-to-Domain Mapping")
struct ReservationMappingTests {

    @Test("Valid API model maps to domain model")
    func validMapping() {
        let apiModel = ReservationApiModel(
            id: 1,
            landmarkId: 1001,
            startDate: "2026-03-15T00:00:00Z",
            endDate: "2026-03-18T00:00:00Z",
            status: "confirmed",
            guestCount: 2,
            notes: "Anniversary trip"
        )

        let reservation = apiModel.domainModel

        #expect(reservation != nil)
        #expect(reservation?.id == 1)
        #expect(reservation?.landmarkId == 1001)
        #expect(reservation?.status == .confirmed)
        #expect(reservation?.guestCount == 2)
        #expect(reservation?.notes == "Anniversary trip")
    }

    @Test("Invalid status returns nil")
    func invalidStatus() {
        let apiModel = ReservationApiModel(
            id: 2,
            landmarkId: 1001,
            startDate: "2026-03-15T00:00:00Z",
            endDate: "2026-03-18T00:00:00Z",
            status: "unknown_status",
            guestCount: 1,
            notes: nil
        )

        #expect(apiModel.domainModel == nil)
    }

    @Test("Invalid date returns nil")
    func invalidDate() {
        let apiModel = ReservationApiModel(
            id: 3,
            landmarkId: 1001,
            startDate: "not-a-date",
            endDate: "2026-03-18T00:00:00Z",
            status: "pending",
            guestCount: 1,
            notes: nil
        )

        #expect(apiModel.domainModel == nil)
    }

    @Test("Nil notes maps correctly")
    func nilNotes() {
        let apiModel = ReservationApiModel(
            id: 4,
            landmarkId: 1002,
            startDate: "2026-04-01T00:00:00Z",
            endDate: "2026-04-05T00:00:00Z",
            status: "pending",
            guestCount: 4,
            notes: nil
        )

        let reservation = apiModel.domainModel

        #expect(reservation != nil)
        #expect(reservation?.notes == nil)
    }
}
