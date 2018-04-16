import Foundation

public struct TagResponse: Codable {
  
  public let meta    : Meta?
  public let links   : Links?
  public let data    : [Data]
  public let included: [Included]?
}

// MARK: - Meta
extension TagResponse {
  
  public struct Meta: Codable {
    
    public struct Page: Codable {
      public let count : Int
      public let offset: Int
    }
    
    public let total_count: Int
    public let sort       : String?
    public let page       : Page?
  }
  
}

// MARK: - Links
extension TagResponse {
  
  public struct Links: Codable {
    
    public let first   : String?
    public let prev    : String?
    public let selfLink: String
    public let next    : String?
    public let last    : String?
    
    enum CodingKeys: String, CodingKey {
      case first    = "first"
      case prev     = "prev"
      case selfLink = "self"
      case next     = "next"
      case last     = "last"
    }
  }
  
}

// MARK: - Data
extension TagResponse {
  
  public struct Data: Codable {
    
    public struct Attributes: Codable {
      
      public let name : String
      public let count: Int
    }
    
    public struct Relationships: Codable {
      
      public struct LibraryBooks: Codable {
        
        public struct Data: Codable {
          
          public let type: String
          public let id  : String
        }
        
        public struct Links: Codable {
          
          public let selfLink: String?
          public let related : String
          
          public enum CodingKeys: String, CodingKey {
            case selfLink = "self"
            case related  = "related"
          }
          
        }
        
        public let data : [Data]?
        public let meta : Meta?
        public let links: Links?
      }
      
      public let libraryBooks: LibraryBooks?
      
      public enum CodingKeys: String, CodingKey {
        case libraryBooks = "library_books"
      }
      
    }
    
    public let type         : String
    public let id           : String
    public let attributes   : Attributes
    public let relationships: Relationships
  }
  
}

// MARK: - Included
extension TagResponse {
  
  public struct Included: Codable {
    
    public struct Attributes: Codable {
      
      public struct Cover: Codable {
        
        public let small: String
      }
      
      public let cover: Cover
    }
    
    public struct Links: Codable {
      
      public let selfLink: String
      public let related : String?
      
      public enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case related  = "related"
      }
      
    }
    
    public let type      : String?
    public let id        : String?
    public let attributes: Attributes?
    public let links     : Links?
  }
  
}

// Get Parameters
extension TagResponse {
  
  static func getParams() -> [String : String] {
    
    let fieldsParamKey       = "fields[books]"
    let libraryBooksParamKey = TagResponse.Data.Relationships.CodingKeys.libraryBooks.stringValue
    let pageParamKey         = "page[\(libraryBooksParamKey)][count]"
    
    return
      [
        fieldsParamKey : "cover",
        pageParamKey   : "6"
      ]
  }
  
}

