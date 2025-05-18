import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  public func histories(
    deviceId: UUID,
    page: UInt = 0,
    maxCount: UInt = 50
  ) async throws -> [History] {
    let url = baseURL
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
  public var tag: String
  public var recordId: UInt
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
