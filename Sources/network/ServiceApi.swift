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
    return "https://api.readmoo.com/read/v2"
    
  }
  var developBaseURL: String {
    return "https://api.readmoo.tw/read/v2"
  }
  
  var path: String {
    switch self {
    case let .meLibraryBooks(id):
      return "/me/library/books" + format(id)
    case let .meLibraryMagazines(id):
      return "/me/library/magazines" + format(id)
    case .meLibraryPublications:
      return "/me/library/publications"
    case let .meLibrarySubscriptions(id):
      return "/me/library/subscriptions" + format(id)
    case let .marathons(id):
      return "/marathons" + format(id)
    case let .meReadings(id):
      return "/me/readings" + format(id)
    case .meActivity:
      return "/me/activity"
    case let .meReviews(id):
      return "/me/reviews/\(id)"
    case let .books(id):
      return "/books/\(id)"
    case let .categories(id):
      return "/categories/\(id)"
    case let .contributors(id):
      return "/contributors/\(id)"
    case let .fragmentsPaths(id):
      return "/fragments/paths/\(id)"
    case let .fragmentsRanges(id):
      return "/fragments/ranges/\(id)"
    case let .publishers(id):
      return "/publishers/\(id)"
    case let .comments(id):
      return "/comments/\(id)"
    case .me:
      return "/me"
    case let .userId(id):
      return "/users/\(id)"
    case let .meBookmarks(id):
      return "/me/bookmarks/\(id)"
    case let .meReadingsBookmarks(id):
      return "/me/readings/\(id)/bookmarks"
    case let .meHighlights(id):
      return "/me/highlights/\(id)"
    case let .meReadingsHighlights(id):
      return "/me/readings/\(id)/highlights"
    case let .meReadingLogs(id):
      return "/me/readinglogs/\(id)"
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
