import Foundation
import SesameRemote
import Testing

@Suite
struct SesameRemoteTests {
  let client = Client(
    httpClient: .urlSession(.shared),
    apiKey: ProcessInfo.processInfo.environment["API_KEY"]!
  )
  
  let deviceId = UUID(uuidString: ProcessInfo.processInfo.environment["DEVICE_ID"]!)!
  let deviceSecretKey = ProcessInfo.processInfo.environment["DEVICE_SECRET_KEY"]!
  
  @Test
  func getDevice() async throws {
    let device = try await client.device(deviceId)
    print(device)
  }
  
  @Test
  func getHistories() async throws {
    let histories = try await client.histories(
      deviceId: deviceId,
      page: 0,
      maxCount: 2
    )
    print(histories)
  }
  
  @Test
  func executeCommand() async throws {
    let result = try await client.execute(
      command: .lock,
      deviceId: deviceId,
      deviceSecretKey: deviceSecretKey,
      history: "test memo"
    )
    print(result)
  }
}
