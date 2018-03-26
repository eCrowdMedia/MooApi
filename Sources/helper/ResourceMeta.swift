import Argo
import Curry
import Runes

public struct ResourceMeta {
  public let totalCount: Int
  public let sort: String?
  public let page: Page?
  
  public struct Page {
    public let count: Int
    public let offset: Int
  }
}

extension ResourceMeta: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceMeta> {
    return curry(ResourceMeta.init)
      <^> json <| "total_count"
      <*> json <|? "sort"
      <*> json <|? "page"
  }
}

extension ResourceMeta.Page: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ResourceMeta.Page> {
    return curry(ResourceMeta.Page.init)
      <^> json <| "count"
      <*> json <| "offset"
  }
}
