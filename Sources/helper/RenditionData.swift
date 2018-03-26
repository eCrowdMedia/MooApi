import Argo
import Curry
import Runes

public struct RenditionData {
  public let layout: String
  /*
  內容呈現方式
  翻頁：paginated
  連續捲動：scrolled-continuous
  單章節捲動：scrolled-doc
  自動：auto
   */
  // [ paginated, scrolled-continuous, scrolled-doc, auto ]
  public let flow: String?
}

extension RenditionData: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<RenditionData> {
    return curry(RenditionData.init)
      <^> json <| "layout"
      <*> json <|? "flow"
  }
  
  
}
