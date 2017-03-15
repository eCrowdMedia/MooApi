import Argo
import Curry
import Runes

public struct ApiDocumentLinks {
  public let selfLink: String
  public let first: String?
  public let preview: String?
  public let next: String?
  public let last: String?
}

extension ApiDocumentLinks: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentLinks> {
    return curry(ApiDocumentLinks.init)
      <^> json <| "self"
      <*> json <|? "first"
      <*> json <|? "prev"
      <*> json <|? "next"
      <*> json <|? "last"
  }
}
