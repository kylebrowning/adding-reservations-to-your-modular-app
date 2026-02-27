import SwiftUI
import ReservationsDomain
import LandmarksDomain

public struct ReservationListView: View {
    @Environment(\.reservationService) private var reservationService
    @Environment(\.landmarkService) private var landmarkService
    @State private var reservations: [Reservation] = []
    @State private var landmarks: [Int: Landmark] = [:]

    public init() {}

    public var body: some View {
        List(reservations) { reservation in
            ReservationRow(
                reservation: reservation,
                landmarkName: landmarks[reservation.landmarkId]?.name
            )
        }
        .navigationTitle("Reservations")
        .task {
            do {
                reservations = try await reservationService.fetchReservations()
                let allLandmarks = try await landmarkService.fetchLandmarks()
                landmarks = Dictionary(
                    uniqueKeysWithValues: allLandmarks.map { ($0.id, $0) }
                )
            } catch {
                // handle error
            }
        }
    }
}

struct ReservationRow: View {
    let reservation: Reservation
    let landmarkName: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(landmarkName ?? "Unknown Landmark")
                .font(.headline)
            Text(reservation.startDate.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(reservation.status.rawValue.capitalized)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(statusColor.opacity(0.2))
                .clipShape(Capsule())
        }
    }

    private var statusColor: Color {
        switch reservation.status {
        case .confirmed: .green
        case .pending: .orange
        case .cancelled: .red
        }
    }
}

#Preview {
    NavigationStack {
        ReservationListView()
    }
    .environment(\.reservationService, .mock)
    .environment(\.landmarkService, .mock)
}
