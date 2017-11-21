//
//  Devices.swift
//  MooApi
//
//  Created by Apple on 2017/11/21.
//  Copyright © 2017年 ecrowdmedia.com. All rights reserved.
//
import Argo
import Curry
import Runes

public struct Devices: ResourceType {
  
  public let type: String
  public let id: String
  public let attributes: Attributes
  public let links: Links
  
  public struct Attributes {
    public let name: String
    public let deviceType: String
    public let userAgent: String
    public let registeredAt: String?
  }
  
  public struct Links {
    public let selfLink: String
  }
}

extension Devices: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Devices> {
    return curry(Devices.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "links"
  }
}

extension Devices.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Devices.Attributes> {
    return curry(Devices.Attributes.init)
      <^> json <|  "name"
      <*> json <|  "device_type"
      <*> json <|  "user_agent"
      <*> json <|? "registered_at"
  }
}

extension Devices.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Devices.Links> {
    return curry(Devices.Links.init)
      <^> json <| "self"
  }
}
