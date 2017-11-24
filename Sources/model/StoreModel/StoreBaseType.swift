//
//  StoreBaseType.swift
//  TestAPI
//
//  Created by Apple on 2017/11/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
public enum StoreBaseType: String {
  case bannerSet = "banner_set"
  case navCircle = "nav_circle"
  case dataColumn = "data_column"
  case rank = "rank"
  case banner = "banner"
  case dataRow = "data_row"
  case navRectangle = "nav_rectangle"
  case footer = "footer"
  case unknow
  
  init(_ string: String) {
    switch string {
    case StoreBaseType.bannerSet.rawValue:
      self = .bannerSet
    case StoreBaseType.navCircle.rawValue:
      self = .navCircle
    case StoreBaseType.dataColumn.rawValue:
      self = .dataColumn
    case StoreBaseType.rank.rawValue:
      self = .rank
    case StoreBaseType.banner.rawValue:
      self = .banner
    case StoreBaseType.dataRow.rawValue:
      self = .dataRow
    case StoreBaseType.navRectangle.rawValue:
      self = .navRectangle
    case StoreBaseType.footer.rawValue:
      self = .footer
    case StoreBaseType.dataRow.rawValue:
      self = .dataRow
    default:
      self = .unknow
    }
  }
}
