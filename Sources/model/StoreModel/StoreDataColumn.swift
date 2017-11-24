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
  public let page: PageItem
  public let books: [BookItem]
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    title = try value.decode(String.self, forKey: .title)
    total = try value.decode(Int.self, forKey: .total)
    page = try value.decode(PageItem.self, forKey: .page)
    books = try value.decode([BookItem].self, forKey: .books)
  }
  
}

extension StoreDataColumn {
  
  public struct PageItem: Decodable {
    public enum CodingKeys: String, CodingKey {
      case type = "type"
      case id = "id"
    }
    
    public var type: String
    public var id: String
  }
}


extension StoreDataColumn {
  public struct BookItem: Decodable {
    
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
    public let covers: Covers
    
    public init(from decoder: Decoder) throws {
      let value = try decoder.container(keyedBy: CodingKeys.self)
      type = try value.decode(String.self, forKey: .type)
      id = try value.decode(String.self, forKey: .id)
      title = try value.decode(String.self, forKey: .title)
      author = try value.decode(String.self, forKey: .author)
      publisher = try value.decode(String.self, forKey: .publisher)
      shortDescription = try value.decode(String.self, forKey: .shortDescription)
      covers = try value.decode(Covers.self, forKey: .covers)
    }
  }
}

extension StoreDataColumn.BookItem {
  public struct Covers: Decodable {
    public enum CodingKeys: String, CodingKey {
      case small = "small"
      case medium = "medium"
      case large = "large"
    }
    
    public let small: String
    public let medium: String
    public let large: String
  }
}

extension StoreDataColumn.BookItem {
  
  public struct Rendition: Decodable {
    public enum CodingKeys: String, CodingKey {
      case layout = "layout"
    }

    public let layout: String
  }
}

