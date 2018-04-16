import Argo
import Curry
import Runes

public struct Reading: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: ReadingAttributes
  public let relationships: Relationships

  public struct Relationships {
    public let book: ResourceIdentifier
    public let bookmarks: ResourceLinks
    public let highlights: ResourceLinks
    public let review: ResourceIdentifier?
  }

}

extension Reading: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading> {
    return curry(Reading.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
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

