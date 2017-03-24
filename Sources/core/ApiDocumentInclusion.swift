import Argo
import Curry
import Runes

final public class ApiDocumentInclusion {
  
  public internal(set) var books         = [Book]()
  public internal(set) var bookshelves   = [Bookshelf]()
  public internal(set) var bookmarks     = [Bookmark]()
  public internal(set) var categories    = [Category]()
  public internal(set) var comments      = [Comment]()
  public internal(set) var contributors  = [Contributor]()
  public internal(set) var events        = [Event]()
  public internal(set) var highlights    = [Highlight]()
  public internal(set) var marathons     = [Marathon]()
  public internal(set) var publishers    = [Publisher]()
  public internal(set) var paths         = [Path]()
  public internal(set) var ranges        = [Range]()
  public internal(set) var readings      = [Reading]()
  public internal(set) var readingLogs   = [ReadingLog]()
  public internal(set) var reviews       = [Review]()
  public internal(set) var subscriptions = [Subscription]()
  public internal(set) var tags          = [Tag]()
  public internal(set) var users         = [User]()
  
  fileprivate enum IncludedType: String {
    case books         = "books"
    case bookshelves   = "library_items"
    case bookmarks     = "bookmarks"
    case categories    = "categories"
    case comments      = "comments"
    case contributors  = "contributors"
    case events        = "events"
    case highlights    = "highlights"
    case marathons     = "marathons"
    case publishers    = "publishers"
    case paths         = "paths"
    case ranges        = "ranges"
    case readings      = "readings"
    case readingLogs   = "readinglogs"
    case reviews       = "reviews"
    case subscriptions = "subscriptions"
    case tags          = "tags"
    case users         = "users"
  }
  
}

// MARK: - Decodable
extension ApiDocumentInclusion: Argo.Decodable {
  
  public static func decode(_ json: JSON) -> Decoded<ApiDocumentInclusion> {
    guard case let .array(jsonArray) = json else {
      return .failure(.typeMismatch(expected: "JSONArray", actual: String(describing: json)))
    }
    
    let included = ApiDocumentInclusion()
    
    for jsonObject in jsonArray {
      guard
        let rawValue: String = (jsonObject <| "type").value,
        let type = ApiDocumentInclusion.IncludedType(rawValue: rawValue)
      else { continue }
      
      switch type {
      case .books:
        if let item = Book.decode(jsonObject).value {
          included.books.append(item)
        }
      case .bookshelves:
        if let item = Bookshelf.decode(jsonObject).value {
          included.bookshelves.append(item)
        }
      case .bookmarks:
        if let item = Bookmark.decode(jsonObject).value {
          included.bookmarks.append(item)
        }
      case .categories:
        if let item = Category.decode(jsonObject).value {
          included.categories.append(item)
        }
      case .comments:
        if let item = Comment.decode(jsonObject).value {
          included.comments.append(item)
        }
      case .contributors:
        if let item = Contributor.decode(jsonObject).value {
          included.contributors.append(item)
        }
      case .events:
        if let item = Event.decode(jsonObject).value {
          included.events.append(item)
        }
      case .highlights:
        if let item = Highlight.decode(jsonObject).value {
          included.highlights.append(item)
        }
      case .marathons:
        if let item = Marathon.decode(jsonObject).value {
          included.marathons.append(item)
        }
      case .publishers:
        if let item = Publisher.decode(jsonObject).value {
          included.publishers.append(item)
        }
      case .paths:
        if let item = Path.decode(jsonObject).value {
          included.paths.append(item)
        }
      case .ranges:
        if let item = Range.decode(jsonObject).value {
          included.ranges.append(item)
        }
      case .readings:
        if let item = Reading.decode(jsonObject).value {
          included.readings.append(item)
        }
      case .readingLogs:
        if let item = ReadingLog.decode(jsonObject).value {
          included.readingLogs.append(item)
        }
      case .reviews:
        if let item = Review.decode(jsonObject).value {
          included.reviews.append(item)
        }
      case .subscriptions:
        if let item = Subscription.decode(jsonObject).value {
          included.subscriptions.append(item)
        }
      case .tags:
        if let item = Tag.decode(jsonObject).value {
          included.tags.append(item)
        }
      case .users:
        if let item = User.decode(jsonObject).value {
          included.users.append(item)
        }
      }
    }
    
    return pure(included)
  }
}
