import Foundation
import Argo
import Result

extension ApiManager {
  
  public class LibraryApi {
    
    public struct BookshelfResult {
      public let bookshelfArray: [Bookshelf]
      public let inclusion: ApiDocumentInclusion
      
      init(bookshelfArray: [Bookshelf],
           inclusion: ApiDocumentInclusion)
      {
        self.bookshelfArray = bookshelfArray
        self.inclusion = inclusion
      }
    }
    ///取得使用者書櫃內全部書籍的資料 success：回傳 BookshelfResult Array & syncDateString
    public static func syncPublications(auth: Authorization,
                                        lastModifiedTime: String?,
                                        isDevelopMent: Bool = false,
                                        failure: @escaping (ServiceError) -> Void,
                                        success: @escaping ([BookshelfResult], String) -> Void)
    {
      var params:[String: String] = ["page[count]": "500"]
      if let modifiedTime = lastModifiedTime {
        params["filter[modified_since]"] = modifiedTime
      }
      
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.meLibraryPublications,
                            authorization: auth,
                            parameters: params,
                            isDevelopMent: isDevelopMent)
      
      service.fetchJSONModelArrayAndHeader(queue: nil) { (result: Result<ApiDocumentEnvelope<Bookshelf>, ServiceError>, allHeader) in
        
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
          // 有 data 沒 included 在書櫃不應該發生
          guard let includedData = value.included else {
            failure(ServiceError.dataNotExisted)
            return
          }
          
          let resultArray:[BookshelfResult] = [BookshelfResult(bookshelfArray: value.data,
                                                               inclusion: includedData)]
          
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray, syncDate)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadBooks(
            auth: auth,
            nextURL: nextPageUrl,
            results: resultArray,
            isDevelopMent: isDevelopMent,
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
    
    static func downloadBooks(auth: Authorization,
                              nextURL: URL,
                              results: [BookshelfResult],
                              isDevelopMent: Bool = false,
                              failure: @escaping (ServiceError) -> Void,
                              then: @escaping ([BookshelfResult]) -> Void)
    {
      let service = Service(ServiceMethod.get,
                            url: nextURL,
                            authorization: auth)
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Bookshelf>, ServiceError>) in
        
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          
          guard let includedData = value.included else {
            failure(ServiceError.dataNotExisted)
            return
          }
          
          var newResults = results
          let result = BookshelfResult(bookshelfArray: value.data,
                                       inclusion: includedData)
          newResults.append(result)
          
          guard let nextUrlString = value.paginationLinks?.next else {
            then(newResults)
            return
          }
          
          guard let nextPageUrl = URL(string: nextUrlString) else {
            failure(ServiceError.nextPageUrlFailure)
            return
          }
          
          downloadBooks(
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
    //
  }
}
