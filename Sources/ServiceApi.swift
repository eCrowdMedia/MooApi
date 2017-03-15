import Foundation

public enum ServiceApi {
  
  case libraryBooks(String?)
  case libraryMagazines(String?)
  case libraryPublications
  case librarySubscriptions(String?)
  case marathons(String)
  case meReadings(String)
  case meActivity
  case meReviews(String)
  case books(String)
  case categories(String)
  case contributors(String)
  case publishers(String)
  
  var baseURL: String {
    return "https://api.readmoo.com"
  }
  
  var path: String {
    switch self {
    case let .libraryBooks(id):
      return "/read/v2/me/library/books" + (id == nil ? "" : "/\(id!)")
    case let .libraryMagazines(id):
      return "/read/v2/me/library/magazines" + (id == nil ? "" : "/\(id!)")
    case .libraryPublications:
      return "/read/v2/me/library/publications"
    case let .librarySubscriptions(id):
      return "/read/v2/me/library/subscriptions" + (id == nil ? "" : "/\(id!)")
    case let .marathons(id):
      return "/read/v2/marathons/\(id)"
    case let .meReadings(id):
      return "/read/v2/me/readings/\(id)"
    case .meActivity:
      return "/read/v2/me/activity"
    case let .meReviews(id):
      return "/read/v2/me/reviews/\(id)"
    case let .books(id):
      return "/read/v2/books/\(id)"
    case let .categories(id):
      return "/read/v2/categories/\(id)"
    case let .contributors(id):
      return "/read/v2/contributors/\(id)"
    case let .publishers(id):
      return "/read/v2/publishers/\(id)"
    }
  }
  
}
