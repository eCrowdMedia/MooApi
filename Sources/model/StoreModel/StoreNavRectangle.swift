//
//  StoreNavRectangle.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

public struct StoreNavRectangle: Codable, StoreDataProtocal {
  
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case page = "page"
  }
  
  public let title: String
  public let page: StoreDataBasePageItem
}
