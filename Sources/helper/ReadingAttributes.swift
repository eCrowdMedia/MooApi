import Argo
import Curry
import Runes

public struct ReadingAttributes {
  //[ new, interesting, reading, finished, abandoned ]
  public let state: String
  //[ everyone, friends, self ]
  public let privacy: String
  public let createdAt: String
  public let startedAt: String?
  public let touchedAt: String?
  public let endedAt: String?
  public let duration: Int
  public let progress: Float
  public let commentsCount: Int?
  public let highlightedCount: Int?
  public let position: Float
  public let positionUpdatedAt: String?
  public let location: String?
  public let rating: Int
}

extension ReadingAttributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingAttributes> {
    let tmp1 = curry(ReadingAttributes.init)
      <^> json <| "state"
      <*> json <| "privacy"
      <*> json <| "created_at"
      <*> json <|? "started_at"
    
    let tmp2 = tmp1
      <*> json <|? "touched_at"
      <*> json <|? "ended_at"
      <*> json <| "duration"
      <*> json <| "progress"
    
    let tmp3 = tmp2
      <*> json <|? "comments_count"
      <*> json <|? "highlights_count"
      <*> json <| "position"
      <*> json <|? "position_updated_at"
    
    return tmp3
      <*> json <|? "location"
      <*> json <| "rating"
  }
  
  
}
