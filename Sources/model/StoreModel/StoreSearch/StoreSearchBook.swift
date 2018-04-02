//
//  StoreSearchBook.swift
//  MooApi
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreSearchBook: Codable {
  
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
    case shortDescription = "short_description"
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
  public let shortDescription: String
}
