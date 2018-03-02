//
//  ApiManagerLibray.swift
//  MooApi
//
//  Created by Developer Readmoo on 2018/3/2.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation
import Argo
import Result

extension ApiManager {
  
  public class LibraryApi {
    
    public struct BookshelfResult {
      public let bookshelfArray: [Bookshelf]
      public var inclusion: ApiDocumentInclusion?
      
      init(bookshelfArray: [Bookshelf],
           inclusion: ApiDocumentInclusion?)
      {
        self.bookshelfArray = bookshelfArray
        self.inclusion = inclusion
      }
    }
    ///取得使用者書櫃內全部書籍的資料
    public static func syncLibrary(auth: Authorization,
                                   lastModifiedTime: String?,
                                   isDevelopMent: Bool = false,
                                   failure: @escaping (ServiceError) -> Void,
                                   success: @escaping ([BookshelfResult]) -> Void)
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
      
      service.fetchJSONModelArray(queue: nil) { (result: Result<ApiDocumentEnvelope<Bookshelf>, ServiceError>) in
        switch result {
        case .success(let value):
          let resultArray:[BookshelfResult] = [BookshelfResult(bookshelfArray: value.data,
                                                               inclusion: value.included)]
          guard let nextUrlString = value.paginationLinks?.next else {
            success(resultArray)
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
              success(closureResults)
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
          
          var newResults = results
          let result = BookshelfResult(bookshelfArray: value.data,
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
    
  }
}
