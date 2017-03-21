import Argo
import Curry
import Runes

public struct Highlight: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let privacy: String
    public let commentsCount: Int
    public let likesCount: Int
    public let highlightedAt: String
  }

  public struct Relationships {
    public let book: RelationshipObject
    public let reading: RelationshipObject?
    public let range: RelationshipObject
    public let comments: RelationshipObjectEnvelope?
  }

  public struct Links {
    public let selfLink: String
    public let related: String
  }
}

extension Highlight: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight> {
    return curry(Highlight.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Highlight.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight.Attributes> {
    return curry(Highlight.Attributes.init)
      <^> json <| "privacy"
      <*> json <| "comments_count"
      <*> json <| "likes_count"
      <*> json <| "highlighted_at"
  }
}

extension Highlight.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight.Relationships> {
    return curry(Highlight.Relationships.init)
      <^> json <| "book"
      <*> json <|? "reaidng"
      <*> json <| "range"
      <*> json <|? "comments"
  }
}

extension Highlight.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight.Links> {
    return curry(Highlight.Links.init)
      <^> json <| "self"
      <*> json <| "related"
  }
}