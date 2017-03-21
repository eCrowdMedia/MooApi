import Argo
import Curry
import Runes

public struct RelationshipObjectWithRoleEnvelope {
  public let data: [ResourceIdentifierWithRole]
  public let meta: ResourceMeta?
  public let links: ResourceLinks?
}

extension RelationshipObjectEnvelope: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<RelationshipObjectEnvelope> {
    return curry(RelationshipObjectEnvelope.init)
      <^> (json <|| "data" <|> .success([]))
      <*> json <|? "meta"
      <*> json <|? "links"
  }
}