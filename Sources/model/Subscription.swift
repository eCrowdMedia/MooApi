import Argo
import Curry
import Runes

public struct Subscription: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

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
  }

  public struct Relationships {
    public let publisher: RelationshipObject
    public let mainSubject: RelationshipObject
    public let bookshelves: RelationshipObjectEnvelope
  }

  public struct Links {
    public let selfLink: String
    public let site: String
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
      <*> json <| "links"
  }
}

extension Subscription.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Attributes> {
    return curry(Subscription.Attributes.init)
      <^> json <| "name"
      <*> json <| "period"
      <*> json <| "content"
      <*> json <| "product_type"
      <*> json <| "adult_only"
      <*> json <| "language"
      <*> json <| "delivered"
      <*> json <| "remaining"
      <*> json <| "auto_renew"
  }
}

extension Subscription.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Relationships> {
    return curry(Subscription.Relationships.init)
      <^> json <| "publisher"
      <*> json <| "main_subject"
      <*> json <| "library_items"
  }
}

extension Subscription.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Subscription.Links> {
    return curry(Subscription.Links.init)
      <^> json <| "self"
      <*> json <| "site"
  }
}