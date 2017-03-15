import Argo
import Curry
import Runes

public struct Book: ResourceType {
  
  // MARK: - Attributes
  
  public let type: String
  public let id: String
  public let title: Title
  public let author: String
  public let descriptionInfo: Description
  public let isbn: String?
  public let language: LanguageType
  public let publicationDate: String?
  public let isAdultOnly: Bool
  public let fileSize: Int
  public let rendition: Rendition
  public let isSuspend: Bool
  public let isOwn: Bool
  public let prices: [Price]
  public let count: Count
  public let links: Links
  
  // MARK: - Relationships
  
  public var publisher: ResourceIdentifier?
  public var contributors: [ResourceIdentifier]
  public var mainSubject: ResourceIdentifier?
  
  public struct Title {
    public let normal: String
    public let subtitle: String?
  }
  
  public struct Description {
    public let short: String?
    public let large: String?
  }
  
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
  
  public struct Links {
    public let selfLink: String
    public let site: String
    public let smallImage: String
    public let mediumImage: String
    public let largeImage: String
  }
}

extension Book: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book> {
    let tmp1 = curry(Book.init)
      <^> json <| "type"
      <*> json <| "id"
    
    let tmp2 = tmp1
      <*> json <| ["attributes"]
      <*> json <| ["attributes", "author"]
      <*> json <| ["attributes"]
      <*> json <|? ["attributes", "isbn"]
    
    let tmp3 = tmp2
      <*> json <| ["attributes", "language"]
      <*> json <|? ["attributes", "publication_date"]
      <*> json <| ["attributes", "adult_only"]
      <*> json <| ["attributes", "file_size"]
      <*> json <| ["attributes", "rendition"]
    
    let tmp4 = tmp3
      <*> json <| ["attributes", "suspend"]
      <*> (json <| ["attributes", "own"] <|> .success(false))
      <*> json <|| ["attributes", "prices"]
      <*> json <| ["attributes", "count"]
    
    return tmp4
      <*> json <| "links"
      <*> json <|? ["relationships", "publisher", "data"]
      <*> (json <|| ["relationships", "contributors", "data"] <|> .success([]))
      <*> json <|? ["relationships", "main_subject", "data"]
  }
}

extension Book.Title: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Title> {
    return curry(Book.Title.init)
      <^> json <| "title"
      <*> json <|? "sub_title"
  }
}

extension Book.Description: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Description> {
    return curry(Book.Description.init)
      <^> json <|? "short_description"
      <*> json <|? "description"
  }
}

extension Book.Rendition: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Rendition> {
    return curry(Book.Rendition.init)
      <^> json <| "layout"
  }
}

extension Book.Price: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Price> {
    return curry(Book.Price.init)
      <^> json <| "PriceType"
      <*> json <| "PriceAmount"
      <*> json <| "CurrencyCode"
  }
}

extension Book.Count: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Count> {
    return curry(Book.Count.init)
      <^> json <| "unit"
      <*> json <| "amount"
  }
}

extension Book.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Book.Links> {
    return curry(Book.Links.init)
      <^> json <| "self"
      <*> json <| "site"
      <*> json <| ["small", "href"]
      <*> json <| ["medium", "href"]
      <*> json <| ["large", "href"]
  }
}
