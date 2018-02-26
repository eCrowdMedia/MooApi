import Argo
import Curry
import Runes

public struct User: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links
  
  public struct Attributes {
    public let nickname: String
  }
  
  public struct Links {
    public let selfLink: String
    public let smallImage: ImageMeta?
    public let mediumImage: ImageMeta?
    public let largeImage: ImageMeta?
  }
}

extension User: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<User> {
    return curry(User.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension User.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<User.Attributes> {
    return curry(User.Attributes.init)
      <^> json <| "nickname"
  }
}

extension User.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<User.Links> {
    return curry(User.Links.init)
      <^> json <| "self"
      <*> json <|? "small"
      <*> json <|? "medium"
      <*> json <|? "large"
  }
}
