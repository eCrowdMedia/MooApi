import Foundation
import Argo
import Result

extension ApiManager {
  
  public class DocumentApi {
    
    public struct DocumentResult {
      public let documentArray: [Document]
      public let inclusion: ApiDocumentInclusion?
      
      init(documentArray: [Document],
           inclusion: ApiDocumentInclusion?)
      {
        self.documentArray = documentArray
        self.inclusion = inclusion
      }
    }
    
    public static func sync(auth: Authorization,
                            lastModifiedTime: String?,
                            isDevelopment: Bool = false,
                            failure: @escaping (ServiceError) -> Void,
                            success: @escaping ([DocumentResult]) -> Void)
    {
      var params:[String: String] = ["page[count]": "500"]
      if let modifiedTime = lastModifiedTime {
        params["filter[modified_since]"] = modifiedTime
      }
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meDocuments(nil),
                            authorization: auth,
                            parameters: params,
                            isDevelopment: isDevelopment)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Document>, ServiceError>) in
        switch result {
        case .success(let value):
          //代表 lastSync 沒資料可以更新，也是成功
          if value.data.count == 0 {
            success([])
            return
          }
          
          let resultArray:[DocumentResult] = [DocumentResult(documentArray: value.data,
                                                             inclusion: value.included)]
          //沒有更多資料，所以結束此遞迴
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray)
            return
          }
          //確保 nextPage 的網址能正常轉換
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          //下載更多的資料
          downloadDocument(
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
        case .failure(let error):
          failure(error)
          
        }
      }
      
    }
  //
  static func downloadDocument(auth: Authorization,
                               nextURL: URL,
                               results: [DocumentResult],
                               isDevelopment: Bool = false,
                               failure: @escaping (ServiceError) -> Void,
                               then: @escaping ([DocumentResult]) -> Void)
  {
    let service = Service(ServiceMethod.get,
                          url: nextURL,
                          authorization: auth)
    service.fetchJSONModelArray(queue: nil) {
      (result: Result<ApiDocumentEnvelope<Document>, ServiceError>) in
      switch result {
      case .failure(let error):
        failure(error)
      case .success(let value):
        //加入新的 result
        var newResults = results
        let result = DocumentResult(documentArray: value.data,
                                    inclusion: value.included)
        newResults.append(result)
        //沒有更多資料，所以結束此遞迴
        guard let nextUrlString = value.paginationLinks?.next else {
          then(newResults)
          return
        }
        //確保 nextPage 的網址能正常轉換
        guard let nextPageUrl = URL(string: nextUrlString) else {
          failure(ServiceError.nextPageUrlFailure)
          return
        }
        //遞迴
        downloadDocument(
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
      break
      }
      
    }
  }
  //
  
  }
}
