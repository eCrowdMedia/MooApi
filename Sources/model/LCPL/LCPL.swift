//
//  LCPL.swift
//  MooApi
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct LCPL: Codable {
  
  public enum CodingKeys: String, CodingKey {
    case id         = "id"
    case provider   = "provider"
    case encryption = "encryption"
    case links      = "links"
  }
  
  public let id: String
  public let provider: String
  public let encryption: LCPLEncryption
  public let links: [LCPLLink]
}

