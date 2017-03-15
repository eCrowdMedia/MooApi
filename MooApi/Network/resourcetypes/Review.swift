import Argo
import Curry
import Runes

public struct Review: ResourceType {
  
  // MARK: - Attributes
  public let type: String
  public let id: String
  public let privacy: PrivacyState
  public let title: String
  public let content: String
  public let commentsCount: Int
  public let likesCount: Int
  public let createdAt: String
  public let lastestModifiedAt: String
  public let link: String
  
  // MARK: - Relationship ids
  
  public var book: ResourceIdentifier?
}

extension Review: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Review> {
    let a = curry(Review.init)
      <^> json <| "type"
      <*> json <| "id"

    let b = a
      <*> json <| ["attributes", "privacy"]
      <*> json <| ["attributes", "title"]
      <*> json <| ["attributes", "content"]
      <*> json <| ["attributes", "comments_count"]
      <*> json <| ["attributes", "likes_count"]
      <*> json <| ["attributes", "created_at"]
      <*> json <| ["attributes", "latest_modified_at"]

    return b 
      <*> json <| ["links", "self"]
      <*> json <|? ["relationships", "book", "data"]
  }
}
