import Argo
import Curry
import Runes

public struct ResourceIdentifier {
  public let type: String
  public let id: String
}

extension ResourceIdentifier: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceIdentifier> {
    return curry(ResourceIdentifier.init)
      <^> json <| "type"
      <*> json <| "id"
  }
}
