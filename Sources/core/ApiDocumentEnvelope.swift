import Argo
import Curry
import Runes

public struct ApiDocumentEnvelope<T: Decodable> where T == T.DecodedType  {
  public let data: [T]
  public let meta: ApiDocumentMeta?
  public let paginationLinks: ApiDocumentLinks?
  public let included: ApiDocumentInclusion?
}

extension ApiDocumentEnvelope: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentEnvelope> {
    let tmp = curry(ApiDocumentEnvelope.init)
      <^> json <|| "data"
      <*> json <|? "meta"
      <*> json <|? "links"
    
    return tmp
      <*> json <|? "included"
  }
}

//extension ApiDocumentEnvelope: CountableStringConvertible {
//  public var countableDescription: String {
//    return "data count: \(data.count)"
//  }
//}
