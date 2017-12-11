//
//  StoreDetailBook.swift
//  MooApi
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreDetailBook: StoreDataProtocal {
  public enum CodingKeys: String, CodingKey {
    case isOwn = "own"
    case type = "type"
    case id = "id"
    case title = "title"
    case author = "author"
    case publisher = "publisher"
    case covers = "covers"
    case isAudlt = "18x"
    case rendition = "rendition"
    case price = "price"
    case isSuspend = "suspend"
    case shipping = "shipping"
    case pageCount = "page_count"
    case shortDescription = "short_description"
    case description = "description"
    case publicationDate = "publication_date"
    case onSaleDate = "on_sale_date"
  }
  
  public let isOwn: Bool
  public let type: String
  public let id: String
  public let title: String
  public let author: String
  public let publisher: String
  public let covers: StoreBookCoverItem
  public let isAudlt: Bool
  public let rendition: StoreBookRenditionItem
  public let price: [StoreBookPrice]
  public let isSuspend: Bool
  public let shipping: Int
  public let pageCount: StoreBookPages
  
  public let shortDescription: String
  public let description: String
  
  public let publicationDate: String
  public let onSaleDate: String?
}
