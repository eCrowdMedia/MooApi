import Argo
import Curry
import Runes

public struct Reading: ResourceType {
  
  // MARK: - Attributes
  public let type: String
  public let id: String
  public let state: String
  public let privacy: String
  public let startedAt: String?
  public let touchedAt: String?
  public let endedAt: String?
  public let duration: Int
  public let progress: Double
  public let commentsCount: Int
  public let highlightedCount: Int
  public let position: Double
  public let positionUpdatedAt: String?
  public let location: String?
  public let rating: Int
  public let links: String
  
  // MARK: - Relationship ids
  
  public let book: ResourceIdentifier?
  public let review: ResourceIdentifier?
  
}

extension Reading: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Reading> {
    let tmp1 = curry(Reading.init)
      <^> json <| "type"
      <*> json <| "id"

    let tmp2 = tmp1 
      <*> json <| ["attributes", "state"]
      <*> json <| ["attributes", "privacy"]
      <*> json <|? ["attributes", "started_at"]
      <*> json <|? ["attributes", "touched_at"]
      <*> json <|? ["attributes", "ended_at"]
      <*> json <| ["attributes", "duration"]

    let tmp3 = tmp2
      <*> json <| ["attributes", "progress"]
      <*> json <| ["attributes", "comments_count"]
      <*> json <| ["attributes", "highlights_count"]
      <*> json <| ["attributes", "position"]
      <*> json <|? ["attributes", "position_updated_at"]
      <*> json <|? ["attributes", "location"]
      <*> json <| ["attributes", "rating"]

    let tmp4 = tmp3 
      <*> json <| ["links", "self"]

    return tmp4 
      <*> json <|? ["relationships", "book", "data"]
      <*> json <|? ["relationships", "review", "data"]
  }
}
