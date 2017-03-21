import Argo
import Curry
import Runes

public struct ResourceIdentifierWithRole {
  public let type: String
  public let id: String
  public let meta: Meta

  public struct Meta {
    public let role: String
    public let metaDescription: String
  }
}

extension ResourceIdentifierWithRole: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceIdentifierWithRole> {
    return curry(ResourceIdentifierWithRole.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "meta"
  }
}

extension ResourceIdentifierWithRole.Meta: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceIdentifierWithRole.Meta> {
    return curry(ResourceIdentifierWithRole.Meta.init)
      <^> json <| "role"
      <*> json <| "description"
  }
}