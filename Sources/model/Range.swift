import Argo
import Curry
import Runes

public struct Range: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes

  public struct Attributes {
    public let fileVersion: String
    public let position: Double
    public let chapter: Int
    public let cfi: String
    public let loc: Int?
    public let title: String?
    public let preContent: String?
    public let content: String
    public let postContent: String?
    public let referencedCount: Int
  }

}

extension Range: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range> {
    return curry(Range.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
  }
}

extension Range.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Range.Attributes> {
    let tmp1 = curry(Range.Attributes.init)
      <^> json <| "file_version"
      <*> json <| "position"
      <*> json <| "chapter"
    
    let tmp2 = tmp1
      <*> json <|  "cfi"
      <*> json <|?  "loc"
      <*> json <|? "title"
      <*> json <|? "pre_content"
      <*> json <|  "content"
    
    return tmp2
      <*> json <|? "post_content"
      <*> json <| "referenced_count"
  }
}

