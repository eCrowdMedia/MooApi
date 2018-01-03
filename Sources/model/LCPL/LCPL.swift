//
//  LCPL.swift
//  MooApi
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct LCPL: ApiDecodable {
  
  public enum CodingKeys: String, CodingKey {
    case id         = "id"
    case provider   = "provider"
    case encryption = "encryption"
    case links      = "links"
  }
  
  let id: String
  let provider: String
  let encryption: LCPLEncryption
  let links: [LCPLLink]
}

