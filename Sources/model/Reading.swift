import Argo
import Curry
import Runes

public struct Reading: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let state: String
    public let privacy: String
    public let startedAt: String?
    public let touchedAt: String?
    public let endedAt: String?
    public let duration: Int
    public let progress: Double
    public let commentsCount: Int
    public let highlightedCount: Int
    public let position: Double
    public let positionUpdatedAt: String?
    public let location: String?
    public let rating: Int
  }

  public struct Relationships {
    public let book: RelationshipObject
    public let bookmarks: RelationshipObject?
    public let highlights: RelationshipObject?
    public let review: RelationshipObject?
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

extension Reading.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading.Attributes> {
    return curry(Reading.Attributes.init)
      <^> json <| "state"
      <*> json <| "privacy"
      <*> json <|? "started_at"
      <*> json <|? "touched_at"
      <*> json <|? "ended_at"
      <*> json <| "duration"
      <*> json <| "progress"
      <*> json <| "comments_count"
      <*> json <| "highlights_count"
      <*> json <| "position"
      <*> json <|? "position_updated_at"
      <*> json <|? "location"
      <*> json <| "rating"
  }
}

extension Reading.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading.Relationships> {
    return curry(Reading.Relationships.init)
      <^> json <| "book"
      <*> json <|? "bookmarks"
      <*> json <|? "highlights"
      <*> json <|? "review"
  }
}

extension Reading.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading.Links> {
    return curry(Reading.Links.init)
      <^> json <| "self"
  }
}
