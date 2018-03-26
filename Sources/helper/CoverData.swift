import Argo
import Curry
import Runes

public struct CoverData {
  public let small: ImageMeta?
  public let medium: ImageMeta
  public let large: ImageMeta?
}

extension CoverData: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<CoverData> {
    return curry(CoverData.init)
      <^> json <|? "small"
      <*> json <| "medium"
      <*> json <|? "large"
  }
}
