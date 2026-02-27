import Foundation
import Toolkit

public enum ReservationEndpoints {
    public static func list() -> Endpoint<EmptyBody, [ReservationApiModel]> {
        Endpoint(path: "/api/reservations", method: .get)
    }

    public static func get(id: Int) -> Endpoint<EmptyBody, ReservationApiModel> {
        Endpoint(path: "/api/reservations/\(id)", method: .get)
    }

    public static func forLandmark(
        id: Int
    ) -> Endpoint<EmptyBody, [ReservationApiModel]> {
        Endpoint(
            path: "/api/reservations",
            method: .get,
            queryItems: [URLQueryItem(name: "landmarkId", value: "\(id)")]
        )
    }
}
