import Foundation

public struct AccountData {
  public let email: String
  public let password: String
  public let clientID: String
  public let clientSecret: String
  public let uuid: String
  
  public init(email: String,
              password: String,
              clientID: String,
              clientSecret: String,
              uuid: String)
  {
    self.email = email
    self.password = password
    self.clientID = clientID
    self.clientSecret = clientSecret
    self.uuid = uuid
  }
  
  public var base64Credentials: String? {
    return "\(clientID):\(clientSecret)"
      .data(using: .utf8)?
      .base64EncodedString(options: [])
  }
  
  public var scope: String? {
    return "reading highlight like comment me library"
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
  
  public var encodingPassword: String? {
    return password.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)
  }
  
  public var encodingEmail: String? {
    return email.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)
  }
  
  public func makeJsonData() -> Data? {
    guard let email = encodingEmail,
      let password = encodingPassword,
      let scope = scope
      else { return nil }
    
    let optionalBody = [
      "grant_type": "password",
      "udid": uuid,
      "username": email,
      "password": password,
      "scope": scope
      ]
      .map({ "\($0)=\($1)" })
      .joined(separator: "&")
      .data(using: .utf8)
    
    
    return optionalBody
  }
  
  public func makeAuthorization() -> Authorization? {
    guard let credentials = base64Credentials else { return nil }
    return Authorization.basic(credentials)
  }
}
