import Argo
import Curry
import Runes

public struct Book: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  
  public struct Attributes {
    public let title: String
    public let subtitle: String?
    public let cover: CoverData
    public let author: String
    public let shortDescription: String?
    public let largeDescription: String?
    public let isbn: String?
    public let language: String
    public let mainSubject: String
    public let publicationDate: String?
    public let isAdultOnly: Bool
    public let urls: Urls
    public let epub: EpubData
    public let isSuspend: Bool
    public let isOwn: Bool
    public let prices: [Price]
    public let count: CountData

    public struct Urls {
      public let webpage: String?
      public let reader: String?
      public let toc: String?
      public let epub: String?
    }
    
    public struct Price {
      // e.g. "02", "04", "12", "99"
      public let type: String
      public let amount: Int
      public let currentyCode: String
    }
  }

  public struct Relationships {
    public let publisher: ResourceIdentifier
    public let contributors: [ResourceIdentifierWithRole]
    public let categories: [ResourceIdentifier]
  }

}

extension Book: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book> {
    return curry(Book.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
  }
}

extension Book.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes> {
    let tmp1 = curry(Book.Attributes.init)
      <^> json <| "title"
      <*> json <|? "subtitle"
      <*> json <| "cover"
      <*> json <| "author"
    
    let tmp2 = tmp1
      <*> json <|? "short_description"
      <*> json <|? "description"
      <*> json <|? "isbn"
      
    let tmp3 = tmp2
      <*> json <| "language"
      <*> json <| "main_subject"
      <*> json <|? "publication_date"
    
    let tmp4 = tmp3
      <*> json <| "adult_only"
      <*> json <| "urls"
      <*> json <| "epub"
      <*> json <| "suspend"
    
    return tmp4
      <*> (json <| "own" <|> .success(false))
      <*> json <|| "prices"
      <*> json <| "count"
  }
}

extension Book.Attributes.Urls: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Attributes.Urls> {
    return curry(Book.Attributes.Urls.init)
      <^> json <|? "webpage"
      <*> json <|? "reader"
      <*> json <|? "toc"
      <*> json <|? "epub"
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

extension Book.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Relationships> {
    return curry(Book.Relationships.init)
      <^> json <| ["publisher", "data"]
      <*> (json <|| ["contributors", "data"] <|> .success([]))
      <*> (json <|| ["categories", "data"] <|> .success([]))
  }
}
