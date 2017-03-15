import Argo
import Curry
import Runes

public struct Tag: ResourceType {
  
  // MARK: - Attributes

  public let type: String
  public let id: String
  public let name: String
  public let link: String
  
  // MARK: - Relationships
  
}

// MARK: - Decodable
extension Tag: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Tag> {
    return curry(Tag.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| ["attributes", "name"] // for test
      <*> json <| ["links", "self"]
  }
}
