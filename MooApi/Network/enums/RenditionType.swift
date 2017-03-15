import Argo

public enum RenditionType: String {
  case reflowable = "reflowable"
  case fixedLayout = "pre-paginated"
}

extension RenditionType: Argo.Decodable {
  
}
