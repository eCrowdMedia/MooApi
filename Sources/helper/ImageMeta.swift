import Argo
import Curry
import Runes

public struct ImageMeta {
  public let href: String
  public let width: Int
  public let resize: String
}

extension ImageMeta: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ImageMeta> {
    return curry(ImageMeta.init)
      <^> json <| "href"
      <*> json <| ["meta", "width"]
      <*> json <| ["meta", "resize"]
  }
}
