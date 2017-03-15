import Argo
import Curry
import Runes

public struct Event: ResourceType {
  public let type: String
  public let id: String
  public let name: String
  public let link: String
}

// MARK: - Decodable
extension Event: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event> {
    return curry(Event.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| ["attributes", "name"]
      <*> json <| ["links", "self"]
  }
}
