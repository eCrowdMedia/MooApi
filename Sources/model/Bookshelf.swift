import Argo
import Curry
import Runes

public struct Bookshelf: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let isNew: Bool
    public let privacy: String
    public let isArchive: Bool
    public let isSubscribable: Bool // if true is magazation, else is book.
    public let conditions: Conditions?
    public let createdAt: String
    public let touchedAt: String

    public struct Conditions {
      public let after: String?
      public let before: String?
    }
  }

  public struct Relationships {
    public let book: RelationshipObject
    public let reading: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
    public let reader: String
    public let epub: String
    public let toc: String
  }

}

extension Bookshelf: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf> {
    return curry(Bookshelf.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Bookshelf.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes> {
    let tmp1 = curry(Bookshelf.Attributes.init)
      <^> json <| "new"
      <*> json <| "privacy"
      <*> json <| "archive"
    
    return tmp1
      <*> json <| "subscribable"
      <*> json <|? "conditions"
      <*> json <| "created_at"
      <*> json <| "touched_at"
  }
}

extension Bookshelf.Attributes.Conditions: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes.Conditions> {
    return curry(Bookshelf.Attributes.Conditions.init)
      <^> json <|? "after"
      <*> json <|? "before"
  }
}

extension Bookshelf.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Relationships> {
    return curry(Bookshelf.Relationships.init)
      <^> json <| "book"
      <*> json <| "reading"
  }
}

extension Bookshelf.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Links> {
    return curry(Bookshelf.Links.init)
      <^> json <| "self"
      <*> json <| "reader"
      <*> json <| "epub"
      <*> json <| "toc"
  }
}
