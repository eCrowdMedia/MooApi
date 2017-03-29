import Argo
import Curry
import Runes

public struct ReadingLog: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let identifier: String
    public let cfi: String
    public let chapter: Int?
    public let duration: Int
    public let progress: Double // 0.0 ~ 1.0
    public let touchedAt: String?
    public let userAgent: String
    public let ip: String?
    public let latitude: Double?
    public let longitude: Double?
  }

  public struct Relationships {
    public let event: ResourceIdentifier
    public let parent: ResourceIdentifier?
    public let reading: ResourceIdentifier
  }

  public struct Links {
    public let selfLink: String
  }

}

extension ReadingLog: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingLog> {
    return curry(ReadingLog.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension ReadingLog.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingLog.Attributes> {
    return curry(ReadingLog.Attributes.init)
      <^> json <| "identifier"
      <*> json <| "cfi"
      <*> json <|? "chapter"
      <*> json <| "duration"
      <*> json <| "progress"
      <*> json <|? "touched_at"
      <*> json <| "user_agent"
      <*> json <|? "ip"
      <*> json <|? "latitude"
      <*> json <|? "longitude"
  }
}

extension ReadingLog.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingLog.Relationships> {
    return curry(ReadingLog.Relationships.init)
      <^> json <| "event"
      <*> json <|? "parent"
      <*> json <| "reading"
  }
}

extension ReadingLog.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingLog.Links> {
    return curry(ReadingLog.Links.init)
      <^> json <| "self"
  }
}
