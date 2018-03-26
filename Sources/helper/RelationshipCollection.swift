import Argo
import Curry
import Runes

public struct RelationshipCollection {
  public let data: [ResourceIdentifier]
  public let meta: ResourceMeta?
  public let links: ResourceLinks?
}

extension RelationshipCollection: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<RelationshipCollection> {
    return curry(RelationshipCollection.init)
      <^> (json <|| "data" <|> .success([]))
      <*> json <|? "meta"
      <*> json <|? "links"
  }
  
}
