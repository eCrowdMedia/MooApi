import Argo
import Curry
import Runes

public struct Category: ResourceType {
  public let type: String
  public let id: String
  public let name: String
  public let link: String

  public let parent: ResourceIdentifier?
}

// MARK: - Decodable
extension Category: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Category> {
    return curry(Category.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| ["attributes", "name"]
      <*> json <| ["links", "self"]
      <*> json <|? ["relationships", "parent", "data"]
  }
}
