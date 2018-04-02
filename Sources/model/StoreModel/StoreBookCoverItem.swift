//
//  StoreBookCoverItem.swift
//  MooApi
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreBookCoverItem: Codable {
  public enum CodingKeys: String, CodingKey {
    case small = "small"
    case medium = "medium"
    case large = "large"
  }
  
  public let small: String
  public let medium: String
  public let large: String
}
