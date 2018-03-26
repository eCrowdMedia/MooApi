import Argo
import Curry
import Runes

public struct Reading: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: ReadingAttributes
  public let relationships: Relationships
  public let links: Links

  public struct Relationships {
    public let book: ResourceIdentifier
    public let bookmarks: ResourceLinks
    public let highlights: ResourceLinks
    public let review: ResourceIdentifier?
  }

  public struct Links {
    public let selfLink: String
  }

}

extension Reading: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading> {
    return curry(Reading.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Reading.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading.Relationships> {
    return curry(Reading.Relationships.init)
      <^> json <| ["book", "data"]
      <*> json <| ["bookmarks", "links"]
      <*> json <| ["highlights", "links"]
      <*> json <|? ["review", "data"]
  }
}

extension Reading.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading.Links> {
    return curry(Reading.Links.init)
      <^> json <| "self"
  }
}
