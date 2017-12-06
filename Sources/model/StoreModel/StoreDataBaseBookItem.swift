//
//  StoreDataBaseItem.swift
//  MooApi
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreDataBaseBookItem: Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case type = "type"
    case id = "id"
    case title = "title"
    case author = "author"
    case publisher = "publisher"
    case shortDescription = "short_description"
    case covers = "covers"
    
  }
  
  public let type: String
  public let id: String
  public let title: String
  public let author: String
  public let publisher: String
  public let shortDescription: String
  public let covers: StoreBookCoverItem
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    type = try value.decode(String.self, forKey: .type)
    id = try value.decode(String.self, forKey: .id)
    title = try value.decode(String.self, forKey: .title)
    author = try value.decode(String.self, forKey: .author)
    publisher = try value.decode(String.self, forKey: .publisher)
    shortDescription = try value.decode(String.self, forKey: .shortDescription)
    covers = try value.decode(StoreBookCoverItem.self, forKey: .covers)
  }
}


