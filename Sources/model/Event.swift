import Argo
import Curry
import Runes

public struct Event: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes

  public struct Attributes {
    public let name: String
  }

}

// MARK: - Decodable
extension Event: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event> {
    return curry(Event.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Event.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event.Attributes> {
    return curry(Event.Attributes.init)
      <^> json <| "name"
  }
}

