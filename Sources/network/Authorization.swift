import Foundation

public enum Authorization {
  case clientId(String)
  case accessToken(String)
}

extension Authorization {
  
  public var header: (value: String, field: String) {
    switch self {
    case .clientId(let id):
      return ("Client \(id)", "Authorization")
    case .accessToken(let id):
      return ("Bearer \(id)", "Authorization")
    }
  }
  
}
