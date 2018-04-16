import Argo
import Curry
import Runes

public struct User: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  
  public struct Attributes {
    public let nickname: String
  }
  
}

extension User: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<User> {
    return curry(User.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension User.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<User.Attributes> {
    return curry(User.Attributes.init)
      <^> json <| "nickname"
  }
}

