import Argo

public enum ReadingState: String {
  case new
  case interesting
  case reading
  case finished
  case abandoned
}

extension ReadingState: Argo.Decodable {
  
}
