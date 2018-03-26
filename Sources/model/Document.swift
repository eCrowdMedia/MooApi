import Argo
import Curry
import Runes

public struct Document: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links
  
  public struct Attributes {
    public let title: String
    public let cover: CoverData
    public let creator: String?
    //enum [ zh-Hant, zh-Hans, en, ja, fr ]
    public let language: String?
    public let file: File
    public let epub: EpubData
    public let count: CountData
    public let reading: ReadingAttributes
    
    public struct File {
      public let filename: String
      public let filesize: Int
      public let fileExtension: String
      public let status: String
      public let createdAt: String
    }
    
  }
  
  public struct Links {
    public let selfLink: String
  }
  
}

extension Document: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Document> {
    return curry(Document.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Document.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Document.Attributes> {
    let tmp1 = curry(Document.Attributes.init)
      <^> json <| "title"
      <*> json <| "cover"
      <*> json <|? "creator"
      <*> json <|? "language"
    
    return tmp1
      <*> json <| "file"
      <*> json <| "epub"
      <*> json <| "count"
      <*> json <| "reading"
  }
  
}

extension Document.Attributes.File: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Document.Attributes.File> {
    return curry(Document.Attributes.File.init)
      <^> json <| "filename"
      <*> json <| "filesize"
      <*> json <| "file_extension"
      <*> json <| "status"
      <*> json <| "created_at"
  }
}

extension Document.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Document.Links> {
    return curry(Document.Links.init)
      <^> json <| "self"
  }
}


