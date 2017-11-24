//
//  StoreApi.swift
//  MooApi
//
//  Created by Apple on 2017/11/21.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public enum StoreApi: ApiProtocol {
  case home
  case collection(String)
  case block(String)
  case category(String)
  case contributor(String)
  
  public var developURI: String {
    return "https://api.readmoo.tw/v2/navigation"
  }
  
  public var baseURI: String {
    return "https://api.readmoo.com/v2/navigation"
  }
  
  public var path: String {
    switch self {
    case .home:
      return "/home?version=2&banner_type=mobile"
    case let .collection(id):
      return "/collection/\(id)"
    case let .block(id):
      return "/block/\(id)"
    case let .category(id):
      return "/category/\(id)"
    case let .contributor(id):
      return "/contributor/\(id)"
    }
  }
  
  
}
