import Foundation

public enum ServiceApi {
  
  case meLibraryBooks(String?)
  case meLibraryMagazines(String?)
  case meLibraryPublications
  case meLibrarySubscriptions(String?)
  case marathons(String?)
  case meReadings(String?)
  case meActivity
  case meReviews(String)
  case books(String)
  case categories(String)
  case contributors(String)
  case fragmentsPaths(String)
  case fragmentsRanges(String)
  case publishers(String)
  case comments(String)
  case me
  case userId(String)
  case meBookmarks(bookmarkId: String)
  case meReadingsBookmarks(readingId: String)
  case meHighlights(highlightId: String)
  case meReadingsHighlights(readingId: String)
  case meReadingLogs(readingLogId: String)

  var baseURL: String {
    return "https://api.readmoo.com"
  }
  
  var path: String {
    switch self {
    case let .meLibraryBooks(id):
      return "/read/v2/me/library/books" + format(id)
    case let .meLibraryMagazines(id):
      return "/read/v2/me/library/magazines" + format(id)
    case .meLibraryPublications:
      return "/read/v2/me/library/publications"
    case let .meLibrarySubscriptions(id):
      return "/read/v2/me/library/subscriptions" + format(id)
    case let .marathons(id):
      return "/read/v2/marathons" + format(id)
    case let .meReadings(id):
      return "/read/v2/me/readings" + format(id)
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
    case let .fragmentsPaths(id):
      return "/read/v2/fragments/paths/\(id)"
    case let .fragmentsRanges(id):
      return "/read/v2/fragments/ranges/\(id)"
    case let .publishers(id):
      return "/read/v2/publishers/\(id)"
    case let .comments(id):
      return "/read/v2/comments/\(id)"
    case .me:
      return "/read/v2/me"
    case let .userId(id):
      return "/read/v2/users/\(id)"
    case let .meBookmarks(id):
      return "/read/v2/me/bookmarks/\(id)"
    case let .meReadingsBookmarks(id):
      return "/read/v2/me/readings/\(id)/bookmarks"
    case let .meHighlights(id):
      return "/read/v2/me/highlights/\(id)"
    case let .meReadingsHighlights(id):
      return "/read/v2/me/readings/\(id)/highlights"
    case let .meReadingLogs(id):
      return "/read/v2/me/readinglogs/\(id)"
    }
  }
  

  private func format(_ id: String?) -> String {
    switch id {
    case .some(let value):
      return "/\(value)"
    case .none:
      return ""
    }
  }

}
