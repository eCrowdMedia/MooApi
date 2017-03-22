import Argo
import Curry
import Runes

public struct Review: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let privacy: String
    public let title: String
    public let content: String
    public let commentsCount: Int
    public let likesCount: Int
    public let createdAt: String
    public let lastestModifiedAt: String
  }

  public struct Relationships {
    public let book: RelationshipObject
    public let reading: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
  }
}

extension Review: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review> {
    return curry(Review.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Review.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review.Attributes> {
    return curry(Review.Attributes.init)
      <^> json <| "privacy"
      <*> json <| "title"
      <*> json <| "content"
      <*> json <| "comments_count"
      <*> json <| "likes_count"
      <*> json <| "created_at"
      <*> json <| "latest_modified_at"
  }
}

extension Review.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review.Relationships> {
    return curry(Review.Relationships.init)
      <^> json <| "book"
      <*> json <| "reading"
  }
}

extension Review.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review.Links> {
    return curry(Review.Links.init)
      <^> json <| "self"
  }
}
