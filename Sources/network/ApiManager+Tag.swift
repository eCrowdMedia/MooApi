import Foundation
import Argo
import Result

extension ApiManager {
  
  public class TagApi {
    
    public struct TagResult {
      public let TagArray: [Tag]
      
      init(TagArray: [Tag])
      {
        self.TagArray = TagArray
      }
    }
    ///取得使用者書櫃內全部標籤的資料 success：回傳 TagResult Array & syncDateString
    public static func syncTags(auth: Authorization,
                                lastModifiedTime: String?,
                                isDevelopment: Bool = false,
                                failure: @escaping (ServiceError) -> Void,
                                success: @escaping ([TagResult], String) -> Void)
    {
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meTags(nil),
                            authorization: auth,
                            parameters: nil,
                            isDevelopment: isDevelopment)
      
      service.fetchJSONModelArrayAndHeader(queue: nil) { (result: Result<ApiDocumentEnvelope<Tag>, ServiceError>, allHeader) in
        
        guard let allHeader = allHeader, let syncDate = allHeader["Date"] as? String else {
          failure(ServiceError.dateNotFound)
          return
        }
        
        switch result {
        case .success(let value):
          //代表 lastSync 沒資料可以更新，也是成功
          if value.data.count == 0 {
            success([], syncDate)
            return
          }
          
          let resultArray:[TagResult] = [TagResult(TagArray: value.data)]
          
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray, syncDate)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
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
              success(closureResults, syncDate)
          })
        case .failure(let error):
          failure(error)
        }
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
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Tag>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          
          var newResults = results
          let result = TagResult(TagArray: value.data)
          newResults.append(result)
          
          guard let nextUrlString = value.paginationLinks?.next else {
            then(newResults)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
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
    }
    //
  }
}
