import Argo
import Curry
import Runes

public struct ApiDocument<T: Argo.Decodable> where T == T.DecodedType {
  public let data: T
  public let meta: ApiDocumentMeta?
  public let paginationLinks: ApiDocumentLinks?
  public let included: ApiDocumentInclusion?
}

extension ApiDocument: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocument> {
    return curry(ApiDocument.init)
      <^> json <| "data"
      <*> json <|? "meta"
      <*> json <|? "links"
      <*> json <|? "included"
  }
}
