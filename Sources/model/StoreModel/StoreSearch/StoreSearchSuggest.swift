//
//  StoreSearchSuggest.swift
//  MooApi
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public struct StoreSearchSuggest: ApiDecodable {
  public let value: String
  public let type: String
  public let id: String
}
