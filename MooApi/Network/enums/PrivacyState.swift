import Argo

public enum PrivacyState: String {
  case `self`
  case everyone
  case friends
}

extension PrivacyState: Argo.Decodable {
  
}
