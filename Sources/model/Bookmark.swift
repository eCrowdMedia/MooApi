import Argo
import Curry
import Runes

public struct Bookmark: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  
  public struct Attributes {
    public let title: String?
    public let note: String?
    public let emoji: String?
    public let color: String?
    public let device: String
    public let bookmarkedAt: String
  }
  
  public struct Relationships {
    public let book: ResourceIdentifier
    public let user: ResourceIdentifier
    public let reading: ResourceIdentifier
    public let path: ResourceIdentifier
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
  }
}

extension Bookmark.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookmark.Attributes> {
    return curry(Bookmark.Attributes.init)
      <^> json <|? "title"
      <*> json <|? "note"
      <*> json <|? "emoji"
      <*> json <|? "color"
      <*> json <|  "device"
      <*> json <| "bookmarked_at"
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
