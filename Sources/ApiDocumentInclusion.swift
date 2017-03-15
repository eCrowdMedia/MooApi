import Argo
import Curry
import Runes

final public class ApiDocumentInclusion {
  
  public var bookshelfs: [Bookshelf] = []
  public var books: [Book] = []
  public var publishers: [Publisher] = []
  public var readings: [Reading] = []
  public var tags: [Tag] = []
  public var subscriptions: [Subscription] = []
  public var marathons: [Marathon] = []
  public var categories: [Category] = []
  public var contributors: [Contributor] = []
  public var readingLogs: [ReadingLog] = []
  public var reviews: [Review] = []
  public var events: [Event] = []
  
  fileprivate enum IncludedType: String {
    case bookshelves   = "library_items"
    case books         = "books"
    case publishers    = "publishers"
    case readings      = "readings"
    case tags          = "tags"
    case subscriptions = "subscriptions"
    case marathons     = "marathons"
    case categories    = "categories"
    case contributors  = "contributors"
    case readingLogs   = "readinglogs"
    case reviews       = "reviews"
    case events        = "events"
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
      guard let rawValue: String = (jsonObject <| "type").value,
        let type = ApiDocumentInclusion.IncludedType(rawValue: rawValue) else { continue }
      
      switch type {
      case .bookshelves:
        if let item = Bookshelf.decode(jsonObject).value {
          included.bookshelfs.append(item)
        }
      case .books:
        if let item = Book.decode(jsonObject).value {
          included.books.append(item)
        }
      case .publishers:
        if let item = Publisher.decode(jsonObject).value {
          included.publishers.append(item)
        }
      case .readings:
        if let item = Reading.decode(jsonObject).value {
          included.readings.append(item)
        }
      case .tags:
        if let item = Tag.decode(jsonObject).value {
          included.tags.append(item)
        }
      case .subscriptions:
        if let item = Subscription.decode(jsonObject).value {
          included.subscriptions.append(item)
        }
      case .marathons:
        if let item = Marathon.decode(jsonObject).value {
          included.marathons.append(item)
        }
      case .categories:
        if let item = Category.decode(jsonObject).value {
          included.categories.append(item)
        }
      case .contributors:
        if let item = Contributor.decode(jsonObject).value {
          included.contributors.append(item)
        }
      case .readingLogs:
        if let item = ReadingLog.decode(jsonObject).value {
          included.readingLogs.append(item)
        }
      case .reviews:
        if let item = Review.decode(jsonObject).value {
          included.reviews.append(item)
        }
      case .events:
        if let item = Event.decode(jsonObject).value {
          included.events.append(item)
        }
      }
    }
    
    return pure(included)
  }
}

// MARK: - CustomStringConvertible
//extension ApiDocumentInclusion: CountableStringConvertible {
//  public var countableDescription: String {
//    let mirror = Mirror(reflecting: self)
//    
//    var displayText = ""
//    
//    for case let (label, value) in mirror.children {
//      guard let label = label, let array = value as? Array<Any> else { continue }
//      displayText += "\n\(label) count: \(array.count)"
//    }
//    
//    return displayText
//  }
//}
