import Argo
import Curry
import Runes

public struct Marathon: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links

  public struct Attributes {
    public let name: String
    public let marathonDescription: String
    public let startedAt: String
    public let endedAt: String
  }

  public struct Links {
    public let selfLink: String
  }
}

extension Marathon: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Marathon> {
    return curry(Marathon.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Marathon.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Marathon.Links> {
    return curry(Marathon.Links.init)
      <^> json <| "self"
      <*> json <|? "publications"
      <*> json <|? "site"
  }
}
