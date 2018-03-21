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
    public let applications: Applications
  }

  public struct Links {
    public let selfLink: String
    public let smallImage: ImageMeta
    public let mediumImage: ImageMeta
    public let largeImage: ImageMeta
  }
  
  public struct Applications {
    public let document: Document
    public let writemoo: Writemoo
  }
  
  public struct Document {
    //文件上傳服務啟用狀態
    public let activated: Bool?
    //雲端空間（MB）
    public let quota: Int?
    //已使用之雲端空間（MB）
    public let usage: Float?
    //已上傳文件數
    public let count: Int?
    //開始時間
    public let startedAt: String?
    //結束時間
    public let endedAt: String?
  }
  
  public struct Writemoo {
    //Writemoo 服務開通狀態
    public let activated: Bool?
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
      <*> json <| "applications"
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

extension Me.Applications: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me.Applications>
  {
    return curry(Me.Applications.init)
      <^> json <| "document"
      <*> json <| "writemoo"
  }
}

extension Me.Document: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me.Document>
  {
    return curry(Me.Document.init)
      <^> json <|? "activated"
      <*> json <|? "quota"
      <*> json <|? "usage"
      <*> json <|? "count"
      <*> json <|? "started_at"
      <*> json <|? "ended_at"
  }
}

extension Me.Writemoo: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Me.Writemoo>
  {
    return curry(Me.Writemoo.init)
      <^> json <|? "activated"
  }
}



