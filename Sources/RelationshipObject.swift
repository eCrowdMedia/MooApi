import Argo
import Curry
import Runes

public struct RelationshipObject {
  public let data: ResourceIdentifier?
  public let meta: ResourceMeta?
  public let links: ResourceLinks?
}

extension RelationshipObject: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<RelationshipObject> {
    return curry(RelationshipObject.init)
      <^> json <|? "data"
      <*> json <|? "meta"
      <*> json <|? "links"
  }
}