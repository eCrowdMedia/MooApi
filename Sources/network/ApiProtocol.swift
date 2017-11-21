//
//  ApiProtocol.swift
//  MooApi
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//

import Foundation

public protocol ApiProtocol {
  var path: String { get }
  var developURI: String { get }
  var baseURI: String { get }
}
