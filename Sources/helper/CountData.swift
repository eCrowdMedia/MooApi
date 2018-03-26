import Argo
import Curry
import Runes

public struct CountData {
  /*
   統計資料類別
   words：CJK 字數
   pages：頁數
   */
  //[ words, pages ]
  public let unit: String
  public let amount: Int
}

extension CountData: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<CountData> {
    return curry(CountData.init)
      <^> json <| "unit"
      <*> json <| "amount"
  }
}
