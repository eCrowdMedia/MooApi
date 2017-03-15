import Argo
import Curry
import Runes

public struct Publisher: ResourceType {
  
  // MARK: - Attributes
  public let type: String
  public let id: String
  public let name: String
  public let link: String
}

// MARK: - Decodable
extension Publisher: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Publisher> {
    return curry(Publisher.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| ["attributes", "name"]
      <*> json <| ["links", "self"]
  }
}
