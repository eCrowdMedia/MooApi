import Argo
import Curry
import Runes

public struct Tag: ResourceType {
  
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
extension Tag: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag> {
    return curry(Tag.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Tag.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag.Attributes> {
    return curry(Tag.Attributes.init)
      <^> json <| "name"
  }
}

extension Tag.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag.Links> {
    return curry(Tag.Links.init)
      <^> json <| "self"
  }
}