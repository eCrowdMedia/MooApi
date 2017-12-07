//
//  StoreCollectionitem.swift
//  MooApi
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreCollectionItem: ApiDecodable {
  public let title: String
  public let description: String?
  public let logo: String?
  public let total: Int
  public let pagination: StoreCollectionPagination
  public let data: [StoreDataBaseBookItem]
}
