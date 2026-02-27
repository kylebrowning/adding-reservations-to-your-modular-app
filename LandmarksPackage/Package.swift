// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LandmarksPackage",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "LandmarksDomain", targets: ["LandmarksDomain"]),
        .library(name: "LandmarksFeature", targets: ["LandmarksFeature"]),
        .library(name: "ReservationsDomain", targets: ["ReservationsDomain"]),
        .library(name: "ReservationsFeature", targets: ["ReservationsFeature"]),
    ],
    targets: [
        // Common layer
        .target(name: "Env"),
        .target(name: "Logger"),
        .target(name: "Toolkit"),

        // Landmarks Api layer
        .target(
            name: "LandmarksApi",
            dependencies: [.env, .toolkit]
        ),

        // Landmarks Domain layer
        .target(
            name: "LandmarksDomain",
            dependencies: [.landmarksApi, .env, .toolkit]
        ),

        // Landmarks Feature layer
        .target(
            name: "LandmarksFeature",
            dependencies: [.landmarksDomain, .env, .toolkit]
        ),

        // Reservations Api layer
        .target(
            name: "ReservationsApi",
            dependencies: [.env, .toolkit]
        ),

        // Reservations Domain layer
        .target(
            name: "ReservationsDomain",
            dependencies: [
                .reservationsApi,
                .landmarksDomain,
                .env,
                .toolkit,
            ]
        ),

        // Reservations Feature layer
        .target(
            name: "ReservationsFeature",
            dependencies: [.reservationsDomain, .env, .toolkit]
        ),

        // Tests
        .testTarget(
            name: "LandmarksDomainTests",
            dependencies: [.landmarksDomain]
        ),
        .testTarget(
            name: "ReservationsDomainTests",
            dependencies: [.reservationsDomain]
        ),
    ]
)

extension Target.Dependency {
    // Common
    static let env: Target.Dependency = "Env"
    static let logger: Target.Dependency = "Logger"
    static let toolkit: Target.Dependency = "Toolkit"

    // Landmarks
    static let landmarksApi: Target.Dependency = "LandmarksApi"
    static let landmarksDomain: Target.Dependency = "LandmarksDomain"
    static let landmarksFeature: Target.Dependency = "LandmarksFeature"

    // Reservations
    static let reservationsApi: Target.Dependency = "ReservationsApi"
    static let reservationsDomain: Target.Dependency = "ReservationsDomain"
    static let reservationsFeature: Target.Dependency = "ReservationsFeature"
}
