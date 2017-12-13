//
//  StoreSearchKeyword.swift
//  MooApi
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreSearchKeyword: ApiDecodable {
  public let total: Int
  public let pagination: StorePagination
  public let data: StoreSearchBook
}
