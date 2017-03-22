import Argo
import Curry
import Runes

public struct Range: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let fileVersion: String
    public let position: Double
    public let chapter: Int
    public let cfi: String
    public let title: String?
    public let preContent: String?
    public let content: String
    public let postContent: String?
    public let referencedCount: Int
  }

  public struct Relationships {
    public let book: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
  }
}

extension Range: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range> {
    return curry(Range.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Range.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range.Attributes> {
    return curry(Range.Attributes.init)
      <^> json <| "file_version"
      <*> json <| "position"
      <*> json <| "chapter"
      <*> json <| "cfi"
      <*> json <|? "title"
      <*> json <|? "pre_content"
      <*> json <| "content"
      <*> json <|? "post_content"
      <*> json <| "referenced_count"
  }
}

extension Range.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range.Relationships> {
    return curry(Range.Relationships.init)
      <^> json <| "book"
  }
}

extension Range.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range.Links> {
    return curry(Range.Links.init)
      <^> json <| "self"
  }
}