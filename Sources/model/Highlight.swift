import Argo
import Curry
import Runes

public struct Highlight: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships

  public struct Attributes {
    public let title: String?
    public let annotation: String?
    public let emoji: String?
    public let color: String
    public let style: String
    public let privacy: String
    public let commentsCount: Int
    public let likesCount: Int
    public let highlightedAt: String
  }

  public struct Relationships {
    public let book: ResourceIdentifier
    public let reading: ResourceIdentifier
    public let range: ResourceIdentifier
    public let comments: ResourceLinks
    public let user: ResourceIdentifier
  }

}

extension Highlight: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight> {
    return curry(Highlight.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
  }
}

extension Highlight.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight.Attributes> {
    return curry(Highlight.Attributes.init)
      <^> json <|? "title"
      <*> json <|? "annotation"
      <*> json <|? "emoji"
      <*> json <|  "color"
      <*> json <|  "style"
      <*> json <|  "privacy_type"
      <*> json <|  "comments_count"
      <*> json <|  "likes_count"
      <*> json <|  "highlighted_at"
  }
}

extension Highlight.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Highlight.Relationships> {
    return curry(Highlight.Relationships.init)
      <^> json <| ["book", "data"]
      <*> json <| ["reading", "data"]
      <*> json <| ["range", "data"]
      <*> json <| ["comments", "links"]
      <*> json <| ["user", "data"]
  }
}
