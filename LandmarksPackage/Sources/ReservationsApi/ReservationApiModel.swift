import Toolkit

public struct ReservationApiModel: ApiModel {
    public let id: Int
    public let landmarkId: Int
    public let startDate: String
    public let endDate: String
    public let status: String
    public let guestCount: Int
    public let notes: String?
}
