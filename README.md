# Adding Reservations to Your Modular App

Companion code for the [Adding Reservations to Your Modular App](https://kylebrowning.com/posts/adding-reservations-to-your-modular-app) blog post, part of the [Modularizing Swift Apps with SPM](https://kylebrowning.com/series/modularizing-swift-apps) series.

## Structure

```
LandmarksPackage/
├── Sources/
│   ├── Env/                       # Environment configuration (Common)
│   ├── Logger/                    # Logging utilities (Common)
│   ├── Toolkit/                   # Shared utilities + NetworkClient (Common)
│   ├── LandmarksApi/              # Landmarks API models + endpoints
│   ├── LandmarksDomain/           # Landmarks domain models, services, mocks
│   ├── LandmarksFeature/          # Landmarks SwiftUI views
│   ├── ReservationsApi/           # Reservations API models + endpoints
│   ├── ReservationsDomain/        # Reservations domain models, services, mocks
│   └── ReservationsFeature/       # Reservations SwiftUI views
└── Tests/
    ├── LandmarksDomainTests/      # Landmarks domain mapping tests
    └── ReservationsDomainTests/   # Reservations domain mapping tests
```

## Building

```bash
cd LandmarksPackage
swift build
swift test
```

## License

MIT
