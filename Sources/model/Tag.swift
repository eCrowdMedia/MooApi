import Argo
import Curry
import Runes

public struct Tag: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let name: String
    public let count: String
  }
  
  public struct Relationships {
    public let libraryItemBooks: [ResourceIdentifier]
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
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Tag.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag.Attributes> {
    return curry(Tag.Attributes.init)
      <^> json <| "name"
      <*> json <| "count"
  }
}

extension Tag.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag.Relationships> {
    return curry(Tag.Relationships.init)
      <^> (json <|| ["library_item-books", "data"] <|> .success([]))
  }
}

extension Tag.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag.Links> {
    return curry(Tag.Links.init)
      <^> json <| "self"
  }
}
