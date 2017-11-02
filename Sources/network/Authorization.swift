import Foundation

public enum Authorization {
  case clientId(String)
  case accessToken(String)
  case basic(String)
}

extension Authorization {
  
  public var header: (value: String, field: String) {
    switch self {
    case .clientId(let id):
      return ("Client \(id)", "Authorization")
    case .accessToken(let id):
      return ("Bearer \(id)", "Authorization")
    case .basic(let credential):
      return ("Basic \(credential)", "Authorization")
    }
  }
  
}

extension Authorization: Equatable {

  public static func ==(lhs: Authorization, rhs: Authorization) -> Bool {
    return lhs.header.value == rhs.header.value
  }

}

