import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  public func histories(
    deviceId: UUID,
    page: UInt = 0,
    maxCount: UInt = 50
  ) async throws -> [History] {
    let url =
      baseURL
      .appending(path: "api/sesame2/\(deviceId)/history")
      .appending(queryItems: [
        .init(name: "page", value: "\(page)"),
        .init(name: "lg", value: "\(maxCount)"),
      ])

    let request = HTTPRequest(
      method: .get,
      url: url,
      headerFields: [.xApiKey: apiKey]
    )

    let (data, _) = try await httpClient.execute(for: request, from: nil)

    let status = try JSONDecoder().decode([History].self, from: data)
    return status
  }
}

public struct History: Codable {
  public var type: Status
  public var timestamp: Double
  public var tag: String?
  public var recordId: UInt

  private enum CodingKeys: String, CodingKey {
    case type
    case timestamp
    case tag = "historyTag"
    case recordId = "recordId"
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.type, forKey: .type)
    try container.encode(self.timestamp, forKey: .timestamp)
    try container.encodeIfPresent(self.tag?.data(using: .utf8)!.base64EncodedString(), forKey: .tag)
    try container.encode(self.recordId, forKey: .recordId)
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.type = try container.decode(History.Status.self, forKey: .type)
    self.timestamp = try container.decode(Double.self, forKey: .timestamp)
    let tag = try container.decodeIfPresent(String.self, forKey: .tag)
    self.tag = tag.flatMap {
      Data(base64Encoded: $0).flatMap { String(data: $0, encoding: .utf8)! }
    }
    self.recordId = try container.decode(UInt.self, forKey: .recordId)
  }
}

extension History {
  public enum Status: UInt, Codable {
    case none
    case bleLock
    case bleUnLock
    case timeChanged
    case autoLockUpdated
    case mechSettingUpdated
    case autoLock
    case manualLocked
    case manualUnlocked
    case manualElse
    case driveLocked
    case driveUnlocked
    case driveFailed
    case bleAdvParameterUpdated
    case wm2Lock
    case wm2Unlock
    case webLock
    case webUnlock
  }
}
