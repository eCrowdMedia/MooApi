import Argo
import Curry
import Runes

public struct Marathon: ResourceType {
  
  // MARK: - Attributes

  public let type: String
  public let id: String
  public let name: String
  public let marathonDescription: String
  public let url: String
  public let startedAt: String
  public let endedAt: String
  public let links: Links

  public struct Links {
    public let selfLink: String
    public let publications: String?
    public let site: String?
  }
}

extension Marathon: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Marathon> {
    let a = curry(Marathon.init)
      <^> json <| "type"
      <*> json <| "id"

    let b = a 
      <*> json <| ["arrtributes", "name"]
      <*> json <| ["arrtributes", "description"]
      <*> json <| ["arrtributes", "url"]
      <*> json <| ["arrtributes", "started_at"]
      <*> json <| ["arrtributes", "ended_at"]

    return b
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
