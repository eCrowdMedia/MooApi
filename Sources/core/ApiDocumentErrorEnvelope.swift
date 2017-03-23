import Argo
import Curry
import Runes

public struct ApiDocumentErrorEnvelope {
  
  public let errors: [ErrorObject]
  
  public struct ErrorObject {
    public let status: String
    public let code: String?
    public let title: String?
    public let detail: String?
    public let links: Links?
    
    public struct Links {
      public let about: String?
    }
  }
}

extension ApiDocumentErrorEnvelope: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentErrorEnvelope> {
    return curry(ApiDocumentErrorEnvelope.init)
      <^> (json <|| "errors" <|> .success([]))
  }
}

extension ApiDocumentErrorEnvelope.ErrorObject: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentErrorEnvelope.ErrorObject> {
    return curry(ApiDocumentErrorEnvelope.ErrorObject.init)
      <^> json <| "status"
      <*> json <|? "code"
      <*> json <|? "title"
      <*> json <|? "detail"
      <*> json <|? "links"
  }
}

extension ApiDocumentErrorEnvelope.ErrorObject.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentErrorEnvelope.ErrorObject.Links> {
    return curry(ApiDocumentErrorEnvelope.ErrorObject.Links.init)
      <^> json <|? "about"
  }
}
