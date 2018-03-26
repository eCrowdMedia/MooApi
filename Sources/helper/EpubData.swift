import Argo
import Curry
import Runes

public struct EpubData {
  public let rendition: RenditionData
  public let filesize: Int
  /*
   EPUB 書檔的大小更新版號，從 1.000 開始，1.000 =小版更=> 1.001 =大版更=> 2.000
   */
  public let latestVersion: String
  public let lastModifiedAt: String
}

extension EpubData: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<EpubData> {
    return curry(EpubData.init)
      <^> json <| "rendition"
      <*> json <| "filesize"
      <*> json <| "latest_version"
      <*> json <| "last_modified_at"
  }
  
  
}
