import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  func device(_ deviceId: UUID) async throws -> Device {
    let url = baseURL
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

struct Device: Codable {
  var batteryPersentage: Int
  var batteryVoltage: Double
  var position: Int
  var chSesame2Status: Status
  var timestamp: Int

  enum CodingKeys: String, CodingKey {
    case batteryPersentage
    case batteryVoltage
    case position
    case chSesame2Status =  "CHSesame2Status"
    case timestamp
  }
  
  enum Status: String, Codable {
    case locked
    case unlocked
    case moved
  }
}

