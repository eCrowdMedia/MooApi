//
//  StoreDataColumn.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

public struct StoreDataColumn: StoreDataProtocal {
  
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
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    title = try value.decode(String.self, forKey: .title)
    total = try value.decode(Int.self, forKey: .total)
    page = try value.decode(StoreDataBasePageItem.self, forKey: .page)
    books = try value.decode([StoreDataBaseBookItem].self, forKey: .books)
  }
  
}
