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
    public let action: String
    public let isNew: Bool
    public let privacy: String
    public let isArchive: Bool
    public let isSubscribable: Bool // if true is magazation, else is book.
  }

  public struct Relationships {
    public let book: RelationshipObject
    public let review: RelationshipObject?
    public let reading: RelationshipObject?
    public let tags: RelationshipObjectEnvelope?
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
    let a = curry(Bookshelf.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Bookshelf.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes> {
    return curry(Bookshelf.Attributes.init)
      <^> json <| "action"
      <*> json <| "new"
      <*> json <| "privacy"
      <*> json <| "archive"
      <*> json <| "subscribable"
  }
}

extension Bookshelf.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Relationships> {
    return curry(Bookshelf.Relationships.init)
      <^> json <| "book"
      <*> json <| "reading"
      <*> json <|? "review"
      <*> json <|? "tags"
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