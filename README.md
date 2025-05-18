# sesame-swift
Sesame for Swift

## Remote Client

```swift
import Foundation
import SesameRemote

let client = Client(
  httpClient: .urlSession(.shared),
  apiKey: "6QEPseazIa3Xssnihfkey8po5jyiWfe53dFiS8uE"
)

let deviceId = UUID(uuidString: "3DE4DE72-AAF9-25C1-8D0F-C9E019BB060C")!

let device = try await client.device(deviceId)
let histories = try await client.histories(deviceId: deviceId)
try await client.execute(
  command: .lock,
  deviceId: deviceId,
  deviceSecretKey: deviceSecretKey,
  history: "Memo: Lock Device"
)
```
