import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  func histories(deviceId: UUID, page: UInt = 0, order: Order = .newest) async throws -> [History] {    
    let url = baseURL
      .appending(path: "api/sesame2/\(deviceId)/history")
      .appending(queryItems: [
        .init(name: "page", value: "\(page)"),
        .init(name: "lg", value: "\(order.rawValue)"),
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

enum Order: UInt {
  case newest = 1
  case oldest = 2
}

struct History: Codable {
  var type: Status
  var timestamp: Double
  var tag: String
  var recordId: UInt
}

extension History {
  enum Status: UInt, Codable {
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
