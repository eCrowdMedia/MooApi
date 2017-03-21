import Argo
import Curry
import Runes

public struct ResourceMeta {
  public let totalCount: Int?
}

extension ResourceMeta: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceMeta> {
    return curry(ResourceMeta.init)
      <^> json <|? "total_count"
  }
}