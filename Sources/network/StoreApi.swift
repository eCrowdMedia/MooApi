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
  case ranks(String)
  case books(String)
  
  public var developURI: String {
    return "https://api.readmoo.tw/v2"
  }
  
  public var baseURI: String {
    return "https://api.readmoo.com/v2"
  }
  
  public var path: String {
    switch self {
    case .home:
      return "/navigation/home?version=2&banner_type=mobile"
    case .collection(let id):
      return "/navigation/collection/\(id)"
    case .block(let id):
      return "/navigation/block/\(id)"
    case let .category(id):
      return "/navigation/category/\(id)"
    case .contributor(let id):
      return "/navigation/contributor/\(id)"
    case .ranks(let id):
      return "/navigation/ranks/\(id)"
    case .books(let id):
      return "/books/\(id)"
    }
  }
  
  
}
