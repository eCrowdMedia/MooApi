import Argo
import Curry
import Runes

public struct Path: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links
  
  public struct Attributes {
    public let fileVersion: String
    public let position: Double
    public let chapter: Int
    public let cfi: String
    public let title: String?
    public let preContent: String?
    public let content: String
    public let postContent: String?
    public let referencedCount: Int
  }

  public struct Links {
    public let selfLink: String
  }
  
}

// MARK: - Decodable
extension Path: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Path> {
    return curry(Path.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Path.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Path.Attributes> {
    return curry(Path.Attributes.init)
      <^> json <| "file_version"
      <*> json <| "position"
      <*> json <| "chapter"
      <*> json <| "cfi"
      <*> json <|? "title"
      <*> json <|? "pre_content"
      <*> json <| "content"
      <*> json <|? "post_content"
      <*> json <| "referenced_count"
  }
}

extension Path.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Path.Links> {
    return curry(Path.Links.init)
      <^> json <| "self"
  }
}
