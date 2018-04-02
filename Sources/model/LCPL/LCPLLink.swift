//
//  LCPLLinks.swift
//  MooApi
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct LCPLLink: Codable {
  
  public enum CodingKeys: String, CodingKey {
    case rel    = "rel"
    case href   = "href"
    case type   = "type"
    case length = "length"
    case hash   = "hash"
  }
  
  public let rel: String
  public let href: String
  public let type: String
  ///單位： Byte
  public let length: Int?
  public let hash: String?
}
