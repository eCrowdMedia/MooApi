import Argo
import Curry
import Runes

public struct Marathon: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes

  public struct Attributes {
    public let name: String
    public let marathonDescription: String
    public let startedAt: String
    public let endedAt: String
  }

}

extension Marathon: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Marathon> {
    return curry(Marathon.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Marathon.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Marathon.Attributes> {
    return curry(Marathon.Attributes.init)
      <^> json <| "name"
      <*> json <| "description"
      <*> json <| "started_at"
      <*> json <| "ended_at"
  }
}

