//
//  StoreCollectionCategoryItem.swift
//  MooApi
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreCollectionCategoryItem: Codable {
  
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case id = "id"
    case covers = "data"
  }
  
  public let title: String
  public let id: String
  public let covers: [String]
}
