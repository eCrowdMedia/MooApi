import Argo
import Curry
import Runes

public struct Event: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links

  public struct Attributes {
    public let name: String
  }

  public struct Links {
    public let selfLink: String
  }
}

// MARK: - Decodable
extension Event: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event> {
    return curry(Event.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Event.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event.Attributes> {
    return curry(Event.Attributes.init)
      <^> json <| "name"
  }
}

extension Event.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Event.Links> {
    return curry(Event.Links.init)
      <^> json <| "self"
  }
}