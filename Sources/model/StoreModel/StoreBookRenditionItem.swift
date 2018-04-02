//
//  StoreBookRenditionItem.swift
//  MooApi
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreBookRenditionItem: Codable {
  public enum CodingKeys: String, CodingKey {
    case layout = "layout"
  }
  
  public let layout: String
}
