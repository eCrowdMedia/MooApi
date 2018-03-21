import Foundation
import Argo
import Result

public class ApiManager {
  
  public class HighlightApi {
    
    public struct HighlightResult {
      public let highlightArray: [Highlight]
      public var inclusion: ApiDocumentInclusion?
      
      init(highlightArray: [Highlight],
           inclusion: ApiDocumentInclusion?)
      {
        self.highlightArray = highlightArray
        self.inclusion = inclusion
      }
    }
    
    public static func sync(readingId: String,
                            auth: Authorization,
                            params: [String: String]? = ["page[count]": "100"],
                            isDevelopMent: Bool = false,
                            failure: @escaping (ServiceError) -> Void,
                            success: @escaping ([HighlightResult]) -> Void)
    {
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meReadingsHighlights(readingId: readingId),
                            authorization: auth,
                            parameters: params,
                            isDevelopMent: isDevelopMent)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Highlight>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          let resultArray: [HighlightResult] = [HighlightResult(highlightArray: value.data,
                                                                inclusion: value.included)]
          
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadHighlight(
            auth: auth,
            nextURL: nextPageUrl,
            results: resultArray,
            isDevelopMent: isDevelopMent,
            failure: { (error) in
              failure(error)
            },
            then: { (closureRessultArray) in
              success(closureRessultArray)
          })
        }
      }
      
    }
    
    static func downloadHighlight(
      auth: Authorization,
      nextURL: URL,
      results: [HighlightResult],
      isDevelopMent: Bool = false,
      failure: @escaping (ServiceError) -> Void,
      then: @escaping ([HighlightResult]) -> Void)
    {
      
      let service = Service(ServiceMethod.get,
                            url: nextURL,
                            authorization: auth)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Highlight>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          
          var newResults = results
          let result = HighlightResult(highlightArray: value.data,
                                       inclusion: value.included)
          newResults.append(result)
          
          guard let nextUrlString = value.paginationLinks?.next else {
            then(newResults)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadHighlight(
            auth: auth,
            nextURL: nextPageUrl,
            results: newResults,
            isDevelopMent: isDevelopMent,
            failure: { (error) in
              failure(error)
            },
            then: { (closureResults) in
              then(closureResults)
            })
        }
      }
    }
    /// callback 回傳 (serverId, serviceError)
    public static func append(readingId: String,
                              highlightData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (String?, ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.post,
                            api: ServiceApi.meReadingsHighlights(readingId: readingId),
                            authorization: auth,
                            parameters: nil,
                            httpBody: highlightData,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        if error != nil {
          completion(nil, error!)
          return
        }
        
        guard let headers = headers, let serverId = headers["Location"] as? String else {
          completion(nil, .headerDataNotExisted)
          return
        }
        completion(serverId, nil)
      }
      
    }
    
    public static func modify(serverId: String,
                              highlightData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.patch,
                            api: ServiceApi.meHighlights(highlightId: serverId),
                            authorization: auth,
                            parameters: nil,
                            httpBody: highlightData,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        
        if error != nil {
          completion(error)
          return
        }
        
        completion(nil)
      }
    }
    
    
    public static func remove(serverId: String,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.delete,
                            api: ServiceApi.meHighlights(highlightId: serverId),
                            authorization: auth,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        
        if error != nil {
          completion(error)
          return
        }
        
        completion(nil)
      }
    }
    
  }
  
  public class BookmarkApi {
    
    public struct BookmarkResult {
      public let bookmarkArray: [Bookmark]
      public var inclusion: ApiDocumentInclusion?
      
      init(bookmarkArray: [Bookmark],
           inclusion: ApiDocumentInclusion?)
      {
        self.bookmarkArray = bookmarkArray
        self.inclusion = inclusion
      }
    }
    
    public static func sync(readingId: String,
                            auth: Authorization,
                            params: [String: String]? = ["page[count]": "100"],
                            isDevelopMent: Bool = false,
                            failure: @escaping (ServiceError) -> Void,
                            success: @escaping ([BookmarkResult]) -> Void)
    {
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meReadingsBookmarks(readingId: readingId),
                            authorization: auth,
                            parameters: params,
                            isDevelopMent: isDevelopMent)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Bookmark>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          let resultArray: [BookmarkResult] = [BookmarkResult(bookmarkArray: value.data,
                                                              inclusion: value.included)]
          
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadBookmark(auth: auth,
                           nextURL: nextPageUrl,
                           results: resultArray,
                           failure: { (error) in
                            failure(error)
                           },
                           then: { (closureResults) in
                            success(closureResults)
                           })
          
        }
      }
      
    }
    
    static func downloadBookmark(
      auth: Authorization,
      nextURL: URL,
      results: [BookmarkResult],
      isDevelopMent: Bool = false,
      failure: @escaping (ServiceError) -> Void,
      then: @escaping ([BookmarkResult]) -> Void)
    {
      
      let service = Service(ServiceMethod.get,
                            url: nextURL,
                            authorization: auth)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Bookmark>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          var newResults = results
          let result = BookmarkResult(bookmarkArray: value.data,
                                      inclusion: value.included)
          newResults.append(result)
          
          guard let nextUrlString = value.paginationLinks?.next else {
            then(newResults)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadBookmark(auth: auth,
                           nextURL: nextPageUrl,
                           results: newResults,
                           failure: { (error) in
                            failure(error)
                           },
                           then: { (closureResults) in
                            then(closureResults)
                           })
        }
      }
    }
    /// callback 回傳 (serverId, serviceError)
    public static func append(readingId: String,
                              bookmarkData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (String?, ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.post,
                            api: ServiceApi.meReadingsBookmarks(readingId: readingId),
                            authorization: auth,
                            httpBody: bookmarkData,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        if error != nil {
          completion(nil, error!)
          return
        }
        
        guard let headers = headers, let serverId = headers["Location"] as? String else {
          completion(nil, .headerDataNotExisted)
          return
        }
        completion(serverId, nil)
      }
    }
    
    public static func modify(serverId: String,
                              bookmarkData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.patch,
                            api: ServiceApi.meBookmarks(bookmarkId: serverId),
                            authorization: auth,
                            httpBody: bookmarkData,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        
        if error != nil {
          completion(error)
          return
        }
        
        completion(nil)
      }
    }
    
    public static func remove(serverId: String,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.delete,
                            api: ServiceApi.meBookmarks(bookmarkId: serverId),
                            authorization: auth,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        
        if error != nil {
          completion(error)
          return
        }
        
        completion(nil)
      }
    }
  }
  
  public class ReadingPingApi {
    
    public static func append(readingId: String,
                              pingData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.post,
                            api: ServiceApi.meReadingsReadinglogs(readingId: readingId),
                            authorization: auth,
                            httpBody: pingData,
                            isDevelopMent: isDevelopMent)
      
      service.uploadJSONData(queue: nil) { (data, headers, error) in
        if error != nil {
          completion(error!)
          return
        }
        
        completion(nil)
      }
    }
  }
  
  public class ReadingApi {
    
    public struct ReadingResult {
      public let reading: Reading
      public var inclusion: ApiDocumentInclusion?
      
      init(reading: Reading,
           inclusion: ApiDocumentInclusion?)
      {
        self.reading = reading
        self.inclusion = inclusion
      }
    }
    
    public static func sync(readingId: String,
                            auth: Authorization,
                            isDevelopMent: Bool = false,
                            failure: @escaping (ServiceError) -> Void,
                            success: @escaping (ReadingResult) -> Void) {
      
      let service: Service = Service(ServiceMethod.get,
                                     api: ServiceApi.meReadings(readingId),
                                     authorization: auth,
                                     isDevelopMent: isDevelopMent)
      
      service.fetchJSONModel(queue: nil) { (result: Result<ApiDocument<Reading>, ServiceError>) in
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          let result = ReadingResult(reading: value.data, inclusion: value.included)
          success(result)
        }
      }
    }
  }
  
}
