//
//  StoreDataBasePageItem.swift
//  MooApi
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreDataBasePageItem: Decodable {
  public enum CodingKeys: String, CodingKey {
    case type = "type"
    case id = "id"
  }
  
  public var type: String
  public var id: String
}
