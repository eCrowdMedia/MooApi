import Argo
import Curry
import Runes

public struct Publisher: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes

  public struct Attributes {
    public let name: String
  }

}

// MARK: - Decodable
extension Publisher: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Publisher> {
    return curry(Publisher.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Publisher.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Publisher.Attributes> {
    return curry(Publisher.Attributes.init)
      <^> json <| "name"
  }
}

