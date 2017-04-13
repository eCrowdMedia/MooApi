import Argo
import Curry
import Runes

public struct Review: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links

  public struct Attributes {
    public let privacy: String
    public let title: String
    public let content: String
    public let commentsCount: Int
    public let likesCount: Int
    public let createdAt: String
    public let latestModifiedAt: String
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
      <*> json <| "links"
  }
}

extension Review.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review.Attributes> {
    let tmp1 = curry(Review.Attributes.init)
      <^> json <| "privacy"
      <*> json <| "title"
      <*> json <| "content"
      <*> json <| "comments_count"
    
    return tmp1
      <*> json <| "likes_count"
      <*> json <| "created_at"
      <*> json <| "latest_modified_at"
  }
}

extension Review.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review.Links> {
    return curry(Review.Links.init)
      <^> json <| "self"
  }
}
