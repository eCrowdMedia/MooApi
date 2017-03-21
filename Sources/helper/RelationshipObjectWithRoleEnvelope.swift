import Argo
import Curry
import Runes

public struct RelationshipObjectWithRoleEnvelope {
  public let data: [ResourceIdentifierWithRole]
  public let meta: ResourceMeta?
  public let links: ResourceLinks?
}

extension RelationshipObjectWithRoleEnvelope: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<RelationshipObjectWithRoleEnvelope> {
    return curry(RelationshipObjectWithRoleEnvelope.init)
      <^> (json <|| "data" <|> .success([]))
      <*> json <|? "meta"
      <*> json <|? "links"
  }
}
