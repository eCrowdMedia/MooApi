import Argo
import Curry
import Runes

public struct Subscription: ResourceType {
  
  // MARK: - Attributes
  public let type: String
  public let id: String
  public let name: String
  public let period: String
  public let content: String
  public let productType: String
  public let isAdulyOnly: Bool
  public let language: String
  public let delivered: Int
  public let remaining: Int
  public let isAutoRenew: Bool
  public let links: Links
  
  // MARK: - Relationships
  
  public var publication: ResourceIdentifier?
  public var mainSubject: ResourceIdentifier?
  public var bookshelves: [ResourceIdentifier]

  public struct Links {
    public let selfLink: String
    public let site: String
  }
}

// MARK: - Decodable
extension Subscription: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription> {
    let a = curry(Subscription.init)
      <^> json <| "type"
      <*> json <| "id"

    let b = a 
      <*> json <| ["attributes", "name"]
      <*> json <| ["attributes", "period"]
      <*> json <| ["attributes", "content"]
      <*> json <| ["attributes", "product_type"]
      <*> json <| ["attributes", "adult_only"]
      <*> json <| ["attributes", "language"]
      <*> json <| ["attributes", "delivered"]
      <*> json <| ["attributes", "remaining"]
      <*> json <| ["attributes", "auto_renew"]

    let c = b
      <*> json <| "links"

    return c
      <*> json <|? ["relationships", "publisher", "data"]
      <*> json <|? ["relationships", "main_subject", "data"]
      <*> (json <|| ["relationships", "library_items", "data"] <|> .success([]))
  }
}

extension Subscription.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Links> {
    return curry(Subscription.Links.init)
      <^> json <| "self"
      <*> json <| "site"
  }
}

