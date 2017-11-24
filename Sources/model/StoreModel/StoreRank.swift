//
//  StoreRank.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

struct StoreRank: StoreDataProtocal {
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case page = "page"
    case books = "books"
  }
  
  public let title: String
  public let page: StoreDataBasePageItem
  public let books: [StoreDataBaseBookItem]
}

