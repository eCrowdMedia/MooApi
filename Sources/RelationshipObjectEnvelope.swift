import Argo
import Curry
import Runes

public struct RelationshipObjectEnvelope {
  public let data: [ResourceIdentifier]
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