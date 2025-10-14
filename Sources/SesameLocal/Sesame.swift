@preconcurrency import CoreBluetooth

extension CBUUID {
  public static let service = CBUUID(string: "0xFD81")
  public static let wifiModuleService = CBUUID(string: "1B7E8251-2877-41C3-B46E-CF057C562524")
  public static let characteristic = CBUUID(string: "16860002-A5AE-9856-B6D3-DBB4C676993E")

  public static let write = CBUUID(string: "ACA0EF7C-EEAA-48AD-9508-19A6CEF6B356")
  public static let notify = CBUUID(string: "8AC32D3f-5CB9-4D44-BEC2-EE689169F626")
}

