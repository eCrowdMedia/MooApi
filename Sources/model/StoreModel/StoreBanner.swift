//
//  Storebanner.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

public struct StoreBanner: StoreDataProtocal {
  
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case image = "image"
    case page = "page"
  }
  
  public let title: String
  public let image: String
  public let page: PageItem
}

extension StoreBanner {
  
  public struct PageItem: Decodable {
    public enum CodingKeys: String, CodingKey {
      case type = "type"
      case id = "id"
    }
    
    public var type: String
    public var id: String
  }
}
