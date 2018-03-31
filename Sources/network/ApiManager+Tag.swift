import Foundation
import Argo
import Result

extension ApiManager {
  
  public class TagApi {
    
    ///取得使用者書櫃內全部標籤的資料 success：回傳 TagResponse
    public static func syncTags(auth: Authorization,
                                lastModifiedTime: String?,
                                isDevelopment: Bool = false,
                                failure: @escaping (ServiceError) -> Void,
                                success: @escaping (TagResponse) -> Void)
    {
      let params:[String: String] = [
        "fields[books]"                   : "cover",
        "page[library_item-books][count]" : "6"
      ]
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meTags(nil),
                            authorization: auth,
                            parameters: params,
                            isDevelopment: isDevelopment)
      
      
      service.fetchJSONModel(queue: nil) { (response: TagResponse?, serviceError) in
        guard serviceError != nil else {
          failure(serviceError!)
          return
        }
        
        guard let response = response else {
          print("TagResponse is no exist")
          return
        }
        
        guard let nextUrlString = response.links?.next else {
          success(response)
          return
        }
        
        guard let nextPageUrl = URL(string: nextUrlString) else {
          failure(.nextPageUrlFailure)
          return
        }
        
        downloadTags(
          auth: auth,
          nextURL: nextPageUrl,
          results: response.data,
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
                              results: [TagResponse.Data],
                              isDevelopment: Bool = false,
                              failure: @escaping (ServiceError) -> Void,
                              then: @escaping (TagResponse) -> Void)
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
          print("TagResponse is no exist")
          return
        }
        
        var newResults = results
        let result = response.data
        newResults.append(contentsOf: result)
        
        guard let nextUrlString = response.links?.next else {
          then(response)
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
