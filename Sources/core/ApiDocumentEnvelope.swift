import Argo
import Curry
import Runes

public struct ApiDocumentEnvelope<T: Argo.Decodable> where T == T.DecodedType  {
  public let data: [T]
  public let meta: ApiDocumentMeta?
  public let paginationLinks: ApiDocumentLinks?
  public let included: ApiDocumentInclusion?
}

extension ApiDocumentEnvelope: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentEnvelope> {
    return curry(ApiDocumentEnvelope.init)
      <^> (json <|| "data" <|> .success([]))
      <*> json <|? "meta"
      <*> json <|? "links"
      <*> json <|? "included"
  }
}
