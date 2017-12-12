//
//  StoreBookPrice.swift
//  MooApi
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreBookPrice: Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case priceType = "PriceType"
    case priceAmount = "PriceAmount"
    case currencyCode = "CurrencyCode"
  }
  
  public let priceType: String
  public let priceAmount: Int
  public let currencyCode: String
}
