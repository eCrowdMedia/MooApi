import Argo
import Curry
import Runes

public struct ReadingLog: ResourceType {
  
  // MARK: - Attributes
  public let type: String
  public let id: String
  
  // UUID formatter
  public let identifier: String
  public let cfi: String
  public let chapter: Int?
  public let duration: Int
  
  // 0.0 ~ 1.0
  public let progress: Double
  public let touchedAt: String?
  public let userAgent: String
  public let ip: String?
  public let latitude: Double?
  public let longitude: Double?
  public let selfLink: String
  
  // MARK: - Relationships
  
  public let reading: ResourceIdentifier?
  public let parent: ResourceIdentifier?
  public let event: ResourceIdentifier?
  
}

extension ReadingLog: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ReadingLog> {
    let tmp1 = curry(ReadingLog.init)
      <^> json <| "type"
      <*> json <| "id"
    
    let tmp2 = tmp1
      <*> json <| ["attributes", "identifier"]
      <*> json <| ["attributes", "cfi"]
      <*> json <|? ["attributes", "chapter"]
      <*> json <| ["attributes", "duration"]
      <*> json <| ["attributes", "progress"]
    
    let tmp3 = tmp2
      <*> json <|? ["attributes", "touched_at"]
      <*> json <| ["attributes", "user_agent"]
      <*> json <|? ["attributes", "ip"]
      <*> json <|? ["attributes", "latitude"]
      <*> json <|? ["attributes", "longitude"]
      <*> json <| ["links", "self"]
    
    return tmp3
      <*> json <|? ["relationships", "reading", "data"]
      <*> json <|? ["relationships", "reading", "parent"]
      <*> json <|? ["relationships", "reading", "event"]
  }
}
