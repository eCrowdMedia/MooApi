import Argo
import Curry
import Runes

public struct Devices: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  
  public struct Attributes {
    public let name: String
    public let deviceType: String
    public let userAgent: String
    public let registeredAt: String?
  }
  
}

extension Devices: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Devices> {
    return curry(Devices.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Devices.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Devices.Attributes> {
    return curry(Devices.Attributes.init)
      <^> json <|  "name"
      <*> json <|  "device_type"
      <*> json <|  "user_agent"
      <*> json <|? "registered_at"
  }
}

