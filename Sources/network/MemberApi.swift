//
//  MemberApi.swift
//  MooApi
//
//  Created by Apple on 2017/10/23.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public enum MemberApi {
  case oauthToken
  
  var memberURL: String {
    return "https://member.readmoo.com"
  }
  
  var developMemberURL: String {
    return "https://member.readmoo.tw"
  }
  
  var path: String {
    switch self {
    case .oauthToken:
      return "/oauth/access_token"
    }
  }
  
}
