import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  public func device(_ deviceId: UUID) async throws -> Device {
    let url =
      baseURL
      .appending(path: "/api/sesame2/\(deviceId)")

    let request = HTTPRequest(
      method: .get,
      url: url,
      headerFields: [.xApiKey: apiKey]
    )

    let (data, _) = try await httpClient.execute(for: request, from: nil)

    let status = try JSONDecoder().decode(Device.self, from: data)
    return status
  }
}

public struct Device: Codable {
  public var batteryPersentage: Int
  public var batteryVoltage: Double
  public var position: Int
  public var status: Status
  public var timestamp: Int

  public enum CodingKeys: String, CodingKey {
    case batteryPersentage
    case batteryVoltage
    case position
    case status = "CHSesame2Status"
    case timestamp
  }

  public enum Status: String, Codable {
    case locked
    case unlocked
    case moved
  }
}
