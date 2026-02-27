import Foundation
import SwiftUI
import Toolkit
import LandmarksDomain

public struct ServiceEnvironment: Sendable {
    public let landmarkService: LandmarkService
    public let reservationService: ReservationService
    public let profileService: ProfileService
    public let scheduleService: ScheduleService

    public init(
        landmarkService: LandmarkService,
        reservationService: ReservationService,
        profileService: ProfileService,
        scheduleService: ScheduleService
    ) {
        self.landmarkService = landmarkService
        self.reservationService = reservationService
        self.profileService = profileService
        self.scheduleService = scheduleService
    }
}

extension ServiceEnvironment {
    public static func live(
        client: NetworkClient,
        baseURL: URL
    ) -> ServiceEnvironment {
        ServiceEnvironment(
            landmarkService: .live(client: client, baseURL: baseURL),
            reservationService: .live(client: client, baseURL: baseURL),
            profileService: .live(client: client, baseURL: baseURL),
            scheduleService: .live(client: client, baseURL: baseURL)
        )
    }

    public static let mock = ServiceEnvironment(
        landmarkService: .mock,
        reservationService: .mock,
        profileService: .mock,
        scheduleService: .mock
    )

    public static let unimplemented = ServiceEnvironment(
        landmarkService: .unimplemented,
        reservationService: .unimplemented,
        profileService: .unimplemented,
        scheduleService: .unimplemented
    )
}

struct ServiceEnvironmentModifier: ViewModifier {
    let environment: ServiceEnvironment

    func body(content: Content) -> some View {
        content
            .environment(\.landmarkService, environment.landmarkService)
            .environment(\.reservationService, environment.reservationService)
            .environment(\.profileService, environment.profileService)
            .environment(\.scheduleService, environment.scheduleService)
    }
}

extension View {
    public func withServiceEnvironment(
        _ environment: ServiceEnvironment
    ) -> some View {
        modifier(ServiceEnvironmentModifier(environment: environment))
    }
}
