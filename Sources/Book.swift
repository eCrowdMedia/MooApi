import Argo
import Curry
import Runes

public struct Book: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links
  
  public struct Attributes {
    public let title: String
    public let subtitle: String?
    public let author: String
    public let shortDescription: String?
    public let largeDescription: String?
    public let isbn: String?
    public let language: String
    public let publicationDate: String?
    public let isAdultOnly: Bool
    public let fileSize: Int
    public let rendition: Rendition
    public let isSuspend: Bool
    public let isOwn: Bool
    public let prices: [Price]
    public let count: Count

    public struct Rendition {
      public let layout: String
    }
    
    public struct Price {
      // e.g. "02", "04", "12", "99"
      public let type: String
      public let amount: Int
      public let currentyCode: String
    }
    
    public struct Count {
      public let unit: String
      public let amount: Int
    }
  }

  public struct Relationships {
    public let publisher: RelationshipObject
    public let contributors: RelationshipObjectWithRoleEnvelope
    public let mainSubject: RelationshipObject
  }

  public struct Links {
    public let selfLink: String
    public let site: String
    public let smallImage: ImageMeta
    public let mediumImage: ImageMeta
    public let largeImage: ImageMeta
  }

}

extension Book: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book> {
    return curry(Book.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Book.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes> {
    return curry(Book.Attributes.init)
      <^> json <| "title"
      <*> json <|? "sub_title"
      <*> json <| "author"
      <*> json <|? "short_description"
      <*> json <|? "description"
      <*> json <|? "isbn"
      <*> json <| "language"
      <*> json <|? "publication_date"
      <*> json <| "adult_only"
      <*> json <| "file_size"
      <*> json <| "rendition"
      <*> json <| "suspend"
      <*> (json <|? "own" <|> .success(false))
      <*> json <|| "prices"
      <*> json <| "count"
  }
}

extension Book.Attributes.Rendition: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes.Rendition> {
    return curry(Book.Attributes.Rendition.init)
      <^> json <| "layout"
  }
}

extension Book.Attributes.Price: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes.Price> {
    return curry(Book.Attributes.Price.init)
      <^> json <| "PriceType"
      <*> json <| "PriceAmount"
      <*> json <| "CurrencyCode"
  }
}

extension Book.Attributes.Count: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes.Count> {
    return curry(Book.Attributes.Count.init)
      <^> json <| "unit"
      <*> json <| "amount"
  }
}

extension Book.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Relationships> {
    return curry(Book.Relationships.init)
      <^> json <| "publisher"
      <*> json <| "contributors"
      <*> json <| "main_subject"
  }
}

extension Book.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Links> {
    return curry(Book.Links.init)
      <^> json <| "self"
      <*> json <| "site"
      <*> json <| "small"
      <*> json <| "medium"
      <*> json <| "large"
  }
}