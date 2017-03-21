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
    public let parent: RelationshipObject?
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
