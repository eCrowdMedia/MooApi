//
//  StoreRow.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

public struct StoreDataRow: StoreDataProtocal {
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case total = "total"
    case page = "page"
    case books = "books"
  }
  
  public let title: String
  public let total: Int
  public let page: StoreDataBasePageItem
  public let books: [StoreDataBaseBookItem]
}



