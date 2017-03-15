import Argo
import Curry
import Runes

public struct Contributor: ResourceType {
  public let type: String
  public let id: String
  public let name: String
  public let link: String
}

// MARK: - Decodable
extension Contributor: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor> {
    return curry(Contributor.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| ["attributes", "name"]
      <*> json <| ["links", "self"]
  }
}
