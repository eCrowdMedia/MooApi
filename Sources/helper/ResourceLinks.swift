import Argo
import Curry
import Runes

public struct ResourceLinks {
  public let related: String
}

extension ResourceLinks: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceLinks> {
    return curry(ResourceLinks.init)
      <^> json <| "related"
  }
}
