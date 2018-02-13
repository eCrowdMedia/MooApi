//
//  ApiManager.swift
//  MooApi
//
//  Created by Developer Readmoo on 2018/2/13.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public class ApiManager {
  public class Highlight {
    public static func append(readingId: String,
                              highlightData: Data,
                              auth: Authorization,
                              isDevelopMent: Bool = false,
                              completion: @escaping (ServiceError?) -> Void)
    {
      
      let service = Service(ServiceMethod.post,
                            api: ServiceApi.meReadingsHighlights(readingId: readingId),
                            authorization: auth,
                            parameters: nil,
                            httpBody: highlightData,
                            isDevelopMent: isDevelopMent)
      service.uploadJSONData(queue: nil) { (data, error) in
        if error != nil {
          completion(error)
        }
        completion(nil)
      }
    }
  }
}
