import Foundation

public enum ReservationError: Error, LocalizedError {
    case notFound
    case invalidData
    case networkError(Error)

    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "Reservation not found."
        case .invalidData:
            return "The reservation data was invalid."
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
