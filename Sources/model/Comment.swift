import Argo
import Curry
import Runes

public struct Comment: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let content: String
    public let postedAt: String
  }

  public struct Relationships {
    public let replyTo: RelationshipObject
    public let commentator: RelationshipObject
    public let highlight: RelationshipObject
    public let review: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
  }
}

extension Comment: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Comment> {
    return curry(Comment.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
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
      <^> json <| "reply_to"
      <*> json <| "commentator"
      <*> json <| "highlight"
      <*> json <| "review"
  }
}

extension Comment.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Comment.Links> {
    return curry(Comment.Links.init)
      <^> json <| "self"
  }
}
