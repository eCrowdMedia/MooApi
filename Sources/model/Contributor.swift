import Argo
import Curry
import Runes

public struct Contributor: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes

  public struct Attributes {
    public let name: String
  }

}

// MARK: - Decodable
extension Contributor: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor> {
    return curry(Contributor.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Contributor.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor.Attributes> {
    return curry(Contributor.Attributes.init)
      <^> json <| "name"
  }
}
