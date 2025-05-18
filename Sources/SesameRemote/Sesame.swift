import HTTPClient
import Foundation
import HTTPTypes
import HTTPTypesFoundation

public struct Client<HTTPClient: HTTPClientProtocol> {
  var httpClient: HTTPClient
  var baseURL = URL(string: "https://app.candyhouse.co")!
  var apiKey: String
  
  public init(
    httpClient: HTTPClient,
    apiKey: String
  ) {
    self.httpClient = httpClient
    self.apiKey = apiKey
  }
}

extension Client: Sendable where HTTPClient: Sendable { }
