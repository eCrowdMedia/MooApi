import Foundation
import Argo
import Result

extension ApiManager {
  
  public class TagApi {
    
    public typealias Tag = TagResponse.Data
    
    public struct TagResult {
      public let TagArray: [Tag]
      
      init(_ TagArray: [Tag])
      {
        self.TagArray = TagArray
      }
    }
    
    ///取得使用者書櫃內全部標籤的資料 success：回傳 TagResponse
    public static func syncTags(auth: Authorization,
                                lastModifiedTime: String?,
                                isDevelopment: Bool = false,
                                failure: @escaping (ServiceError) -> Void,
                                success: @escaping ([TagResult]) -> Void)
    {
      let params:[String: String] = TagResponse.getParams()
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meTags(nil),
                            authorization: auth,
                            parameters: params,
                            isDevelopment: isDevelopment)
      
      
      service.fetchJSONModel(queue: nil) { (response: TagResponse?, serviceError) in
        if serviceError != nil {
          failure(serviceError!)
          return
        }
        
        guard let response = response else {
          failure(.dataNotExisted)
          return
        }
        
        let tagArray = response.data
        
        let resultArray: [TagResult] = [TagResult(tagArray)]
        
        guard let nextUrlString = response.links?.next else {
          success(resultArray)
          return
        }
        
        guard let nextPageUrl = URL(string: nextUrlString) else {
          failure(.nextPageUrlFailure)
          return
        }
        
        downloadTags(
          auth: auth,
          nextURL: nextPageUrl,
          results: resultArray,
          isDevelopment: isDevelopment,
          failure: { (error) in
            failure(error)
        },
          then: { (closureResults) in
            success(closureResults)
        })
        
        
      }
      
    }
    
    static func downloadTags(auth: Authorization,
                              nextURL: URL,
                              results: [TagResult],
                              isDevelopment: Bool = false,
                              failure: @escaping (ServiceError) -> Void,
                              then: @escaping ([TagResult]) -> Void)
    {
      let service = Service(ServiceMethod.get,
                            url: nextURL,
                            authorization: auth)

      service.fetchJSONModel(queue: nil) { (response: TagResponse?, serviceError) in
        
        guard serviceError != nil else {
          failure(serviceError!)
          return
        }
        
        guard let response = response else {
          failure(.dataNotExisted)
          return
        }
        
        var newResults = results
        let result = TagResult(response.data)
        newResults.append(result)
        
        guard let nextUrlString = response.links?.next else {
          then(newResults)
          return
        }
        
        guard let nextPageUrl = URL(string: nextUrlString) else {
          failure(.nextPageUrlFailure)
          return
        }
        
        downloadTags(
          auth: auth,
          nextURL: nextPageUrl,
          results: newResults,
          isDevelopment: isDevelopment,
          failure: { (error) in
            failure(error)
        },
          then: { (closureResults) in
            then(closureResults)
        })
      }
    }
    //
  }
}
