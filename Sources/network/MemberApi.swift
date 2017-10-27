//
//  MemberApi.swift
//  MooApi
//
//  Created by Apple on 2017/10/23.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public enum MemberApi: ApiProtocol {
  case oauthToken
  
  public var developURI: String {
    return "https://member.readmoo.tw"
  }
  
  public var baseURI: String {
    return "https://member.readmoo.com"
  }
  
  public var path: String {
    switch self {
    case .oauthToken:
      return "/oauth/access_token"
    }
  }
  
  var type: String {
    return String(describing: self.self)
  }
}
