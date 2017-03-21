import Argo
import Curry
import Runes

public struct Bookshelf: ResourceType {
  
  // MARK: - Attributes

  public let type: String
  public let id: String
  public let action: String
  public let isNew: Bool
  public let privacy: String
  public let isArchive: Bool
  public let isSubscribable: Bool // if true is magazation, else is book.
  public let links: Links
  
  // MARK: - Relationship ids
  
  public var book: ResourceIdentifier?
  public var review: ResourceIdentifier?
  public var tags: [ResourceIdentifier]
  public var reading: ResourceIdentifier?
  
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

    let b = a 
      <*> json <| ["attributes", "action"]
      <*> json <| ["attributes", "new"]
      <*> json <| ["attributes", "privacy"]
      <*> json <| ["attributes", "archive"]
      <*> json <| ["attributes", "subscribable"]
      <*> json <| "links"

    return b
      <*> json <|? ["relationships", "book", "data"]
      <*> json <|? ["relationships", "review", "data"]
      <*> (json <|| ["relationships", "tags", "data"] <|> .success([]))
      <*> json <|? ["relationships", "reading", "data"]
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
