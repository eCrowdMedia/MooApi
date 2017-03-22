import Argo
import Curry
import Runes

public struct Category: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let name: String
  }

  public struct Relationships {
    public let parent: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
  }

}

// MARK: - Decodable
extension Category: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Category> {
    return curry(Category.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Category.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Category.Attributes> {
    return curry(Category.Attributes.init)
      <^> json <| "name"
  }
}

extension Category.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Category.Relationships> {
    return curry(Category.Relationships.init)
      <^> json <| "parent"
  }
}

extension Category.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Category.Links> {
    return curry(Category.Links.init)
      <^> json <| "self"
  }
}
