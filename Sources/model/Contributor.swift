import Argo
import Curry
import Runes

public struct Contributor: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links

  public struct Attributes {
    public let name: String
  }

  public struct Links {
    public let selfLink: String
  }
}

// MARK: - Decodable
extension Contributor: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor> {
    return curry(Contributor.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Contributor.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor.Attributes> {
    return curry(Contributor.Attributes.init)
      <^> json <| "name"
  }
}

extension Contributor.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Contributor.Links> {
    return curry(Contributor.Links.init)
      <^> json <| "self"
  }
}