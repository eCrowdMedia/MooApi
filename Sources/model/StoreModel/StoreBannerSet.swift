//
//  StoreBannerItem.swift
//  MooApi
//
//  Created by Apple on 2017/11/21.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreBannerSet: StoreDataProtocal {
  
  public enum CodingKeys: String, CodingKey {
    case title = "title"
    case image = "image"
    case startTime = "start_time"
    case endTime = "end_time"
    case page = "page"
  }
  
  public var title: String
  public var image: String
  public var startTime: String
  public var endTime: String
  public var page: PageItem
 
}

extension StoreBannerSet {
  
  public struct PageItem: Decodable {
    public enum CodingKeys: String, CodingKey {
      case type = "type"
      case id = "id"
    }
    
    public var type: String
    public var id: String
  }
  
}
