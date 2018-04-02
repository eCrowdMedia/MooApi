//
//  StoreDetailBookData.swift
//  MooApi
//
//  Created by Apple on 2017/12/12.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreDetailBookData: Codable {
  public enum CodingKeys: String, CodingKey {
    case data = "data"
  }
  public let data: StoreDetailBook
}
