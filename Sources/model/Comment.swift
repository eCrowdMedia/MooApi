import Argo
import Curry
import Runes

public struct Comment: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships

  public struct Attributes {
    public let content: String
    public let postedAt: String
  }

  public struct Relationships {
    public let replyTo: ResourceIdentifier?
    public let commentator: ResourceIdentifier
    public let highlight: ResourceLinks
    public let review: ResourceIdentifier?
  }

}

extension Comment: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Comment> {
    return curry(Comment.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
  }
}

extension Comment.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Comment.Attributes> {
    return curry(Comment.Attributes.init)
      <^> json <| "content"
      <*> json <| "posted_at"
  }
}

extension Comment.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Comment.Relationships> {
    return curry(Comment.Relationships.init)
      <^> json <|? ["reply_to", "data"]
      <*> json <| ["commentator", "data"]
      <*> json <| ["highlight", "links"]
      <*> json <|? ["review", "data"]
  }
}
