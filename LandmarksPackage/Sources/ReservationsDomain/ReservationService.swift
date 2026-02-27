import Foundation
import ReservationsApi
import Toolkit

public struct ReservationService: Sendable {
    public var fetchReservations: @Sendable () async throws -> [Reservation]
    public var fetchReservation: @Sendable (Int) async throws -> Reservation
    public var fetchReservationsForLandmark: @Sendable (Int) async throws -> [Reservation]

    public init(
        fetchReservations: @escaping @Sendable () async throws -> [Reservation],
        fetchReservation: @escaping @Sendable (Int) async throws -> Reservation,
        fetchReservationsForLandmark: @escaping @Sendable (Int) async throws -> [Reservation]
    ) {
        self.fetchReservations = fetchReservations
        self.fetchReservation = fetchReservation
        self.fetchReservationsForLandmark = fetchReservationsForLandmark
    }
}

// MARK: - Live

extension ReservationService {
    public static func live(
        client: NetworkClient,
        baseURL: URL
    ) -> ReservationService {
        ReservationService(
            fetchReservations: {
                let apiModels = try await client.get(
                    baseURL, ReservationEndpoints.list()
                )
                return apiModels.compactMap(\.domainModel)
            },
            fetchReservation: { id in
                let apiModel = try await client.get(
                    baseURL, ReservationEndpoints.get(id: id)
                )
                guard let reservation = apiModel.domainModel else {
                    throw ReservationError.invalidData
                }
                return reservation
            },
            fetchReservationsForLandmark: { landmarkId in
                let apiModels = try await client.get(
                    baseURL, ReservationEndpoints.forLandmark(id: landmarkId)
                )
                return apiModels.compactMap(\.domainModel)
            }
        )
    }
}

// MARK: - Mock

extension ReservationService {
    public static let mock = ReservationService(
        fetchReservations: {
            try? await Task.sleep(for: .milliseconds(200))
            return Reservation.mocks
        },
        fetchReservation: { id in
            try? await Task.sleep(for: .milliseconds(100))
            guard let reservation = Reservation.mocks.first(
                where: { $0.id == id }
            ) else {
                throw ReservationError.notFound
            }
            return reservation
        },
        fetchReservationsForLandmark: { landmarkId in
            try? await Task.sleep(for: .milliseconds(150))
            return Reservation.mocks.filter {
                $0.landmarkId == landmarkId
            }
        }
    )

    public static let unimplemented = ReservationService(
        fetchReservations: {
            fatalError("fetchReservations unimplemented")
        },
        fetchReservation: { _ in
            fatalError("fetchReservation unimplemented")
        },
        fetchReservationsForLandmark: { _ in
            fatalError("fetchReservationsForLandmark unimplemented")
        }
    )
}
