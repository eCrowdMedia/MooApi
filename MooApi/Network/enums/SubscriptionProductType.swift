import Argo

public enum SubscriptionProductType: String {
  case book
  case magaine
}

extension SubscriptionProductType: Argo.Decodable {
  
}
