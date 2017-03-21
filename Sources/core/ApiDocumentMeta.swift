import Argo
import Curry
import Runes

public struct ApiDocumentMeta {
  public let totalCount: Int
  public let sort: String?
  public let page: Page?
  
  public struct Page {
    public let count: Int
    public let offset: Int
  }
}

extension ApiDocumentMeta: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentMeta> {
    return curry(ApiDocumentMeta.init)
      <^> json <| "total_count"
      <*> json <|? "sort"
      <*> json <|? "page"
  }
}

extension ApiDocumentMeta.Page: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentMeta.Page> {
    return curry(ApiDocumentMeta.Page.init)
      <^> json <| "count"
      <*> json <| "offset"
  }
}
