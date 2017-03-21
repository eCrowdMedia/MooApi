import Argo
import Curry
import Runes

public struct Me: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links

  public struct Attributes {
    public let nickname: String
    public let email: String
    public let activateStatus: String
    public let isDeviceAccount: Bool
  }

  public struct Links {
    public let selfLink: String
    public let smallImage: ImageMeta
    public let mediumImage: ImageMeta
    public let largeImage: ImageMeta
  }
}

extension Me: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me> {
    return curry(Me.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Me.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me.Attributes> {
    return curry(Me.Attributes.init)
      <^> json <| "nickname"
      <*> json <| "email"
      <*> json <| "activate_status"
      <*> json <| "device_account"
  }
}

extension Me.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me.Links> {
    return curry(Me.Links.init)
      <^> json <| "self"
      <*> json <| "small"
      <*> json <| "medium"
      <*> json <| "large"
  }
}
