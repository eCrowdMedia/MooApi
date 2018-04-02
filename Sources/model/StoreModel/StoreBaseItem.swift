//
//  StoreBaseItem.swift
//  TestAPI
//
//  Created by Apple on 2017/11/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation

public struct StoreBaseItem: ApiDecodable {
  
  public enum CodingKeys: String, CodingKey {
    case partial = "partial"
    case data = "data"
    case type = "type"
  }
  
  public var partial: String
  public var data: [StoreDataProtocal]
  public var type: StoreBaseType
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    partial = try value.decode(String.self, forKey: .partial)
    type = StoreBaseType(partial)
    switch type {
    case .bannerSet:
      data = try value.decode([StoreBannerSet].self, forKey: .data)
    case .navCircle:
      data = try value.decode([StoreNavCircle].self, forKey: .data)
    case .dataColumn:
      data = try value.decode([StoreDataColumn].self, forKey: .data)
    case .rank:
      data = try value.decode([StoreRank].self, forKey: .data)
    case .banner:
      data = try value.decode([StoreBanner].self, forKey: .data)
    case .dataRow:
      data = try value.decode([StoreDataRow].self, forKey: .data)
    case .navRectangle:
      data = try value.decode([StoreNavRectangle].self, forKey: .data)
    case .footer:
      data = try value.decode([StoreFooter].self, forKey: .data)
    default:
      data = []
    }
    
  }
  
  public func encode(to encoder: Encoder) throws {
    
  }
  
}
