import Argo
import Curry
import Runes

public struct Bookmark: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links
  
  public struct Attributes {
    public let bookmarkedAt: String
  }
  
  public struct Relationships {
    public let book: ResourceIdentifier
    public let user: ResourceIdentifier
    public let reading: ResourceIdentifier
    public let path: ResourceIdentifier
  }
  
  public struct Links {
    public let selfLink: String
  }
  
}

// MARK: - Decodable
extension Bookmark: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookmark> {
    return curry(Bookmark.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Bookmark.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookmark.Attributes> {
    return curry(Bookmark.Attributes.init)
      <^> json <| "bookmarked_at"
  }
}

extension Bookmark.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookmark.Relationships> {
    return curry(Bookmark.Relationships.init)
      <^> json <| ["book", "data"]
      <*> json <| ["user", "data"]
      <*> json <| ["reading", "data"]
      <*> json <| ["path", "data"]
  }
}

extension Bookmark.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookmark.Links> {
    return curry(Bookmark.Links.init)
      <^> json <| "self"
  }
}
