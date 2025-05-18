import Crypto
import Foundation
import HTTPTypes
import HTTPTypesFoundation

extension Client {
  public func execute(
    command: Command,
    deviceId: UUID,
    deviceSecretKey: String,
    history: String
  ) async throws -> ExecuteCommandResult {
    let url =
      baseURL
      .appending(path: "/api/sesame2/\(deviceId)/cmd")

    let timestamp = UInt32(Date.now.timeIntervalSince1970)
    let timestampSlice = timestamp.data[1..<4]

    let sign = try AES.GCM.seal(
      timestampSlice,
      using: .init(data: deviceSecretKey.data(using: .utf8)!)
    )

    let command = CommandBody(
      command: command,
      history: history.data(using: .utf8)!.base64EncodedString(),
      sign: sign.tag.base64EncodedString()
    )

    let body = try JSONEncoder().encode(command)

    let request = HTTPRequest(
      method: .post,
      url: url,
      headerFields: [.xApiKey: apiKey]
    )

    let (data, _) = try await httpClient.execute(for: request, from: body)
    let result = try JSONDecoder().decode(ExecuteCommandResult.self, from: data)
    return result
  }
}

public struct ExecuteCommandResult: Codable {
  public var statusCode: Int
}

private struct CommandBody: Encodable {
  var command: Command
  var history: String
  var sign: String

  enum CodingKeys: String, CodingKey {
    case command = "cmd"
    case history
    case sign
  }
}

public enum Command: UInt, Codable {
  case toggle = 88
  case lock = 82
  case unlock = 83
}

extension UInt32 {
  fileprivate var data: Data {
    var int = self
    return Data(bytes: &int, count: MemoryLayout<Self>.size)
  }
}
