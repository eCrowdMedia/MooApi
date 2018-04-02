//
//  LCPLEncryption.swift
//  MooApi
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct LCPLEncryption: Codable {

  public struct ContentKey: Codable {
    
    public enum CodingKeys: String, CodingKey {
      case encryptedValue = "encrypted_value"
      case algorithm = "algorithm"
    }
    
    public let encryptedValue: String
    public let algorithm: String
  }
  
  public struct UserKey: Codable {
    
    public enum CodingKeys: String, CodingKey {
      case textHint = "text_hint"
      case algorithm = "algorithm"
      case keyCheck = "key_check"
    }
    
    public let textHint: String
    public let algorithm: String
    public let keyCheck: String
  }
  
  public enum CodingKeys: String, CodingKey {
    case profile    = "profile"
    case contentKey = "content_key"
    case userKey    = "user_key"
  }
  
  public let profile: String
  public let contentKey: ContentKey
  public let userKey: UserKey
}
