import Argo
import Curry
import Runes

public struct Subscription: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships

  public struct Attributes {
    public let name: String
    public let period: String
    public let content: String
    public let productType: String
    public let isAdultOnly: Bool
    public let language: String
    public let delivered: Int
    public let remaining: Int
    public let isAutoRenew: Bool
    public let urls: Urls?
    
    public struct Urls {
      public let webpage: String?
    }
    
  }
  

  public struct Relationships {
    public let publisher: ResourceIdentifier
    public let categories: [ResourceIdentifier]
    public let bookshelves: [ResourceIdentifier]
  }

}

// MARK: - Decodable
extension Subscription: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription> {
    return curry(Subscription.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
  }
}

extension Subscription.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Attributes> {
    let tmp1 = curry(Subscription.Attributes.init)
      <^> json <| "name"
      <*> json <| "period"
      <*> json <| "content"
      <*> json <| "product_type"
    
    let tmp2 = tmp1
      <*> json <| "adult_only"
      <*> json <| "language"
      <*> json <| "delivered"
      <*> json <| "remaining"
      
    return tmp2
      <*> json <| "auto_renew"
      <*> json <|? "urls"
  }
}

extension Subscription.Attributes.Urls: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Attributes.Urls> {
    return curry(Subscription.Attributes.Urls.init)
      <^> json <|? "webpage"
  }
}

extension Subscription.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Relationships> {
    return curry(Subscription.Relationships.init)
      <^> json <| ["publisher", "data"]
      <*> (json <|| ["categories", "data"] <|> .success([]))
      <*> (json <|| ["library_items", "data"] <|> .success([]))
  }
}

