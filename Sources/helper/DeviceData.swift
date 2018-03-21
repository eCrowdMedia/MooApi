import Foundation
///帳號裝置的資料
public struct DeviceData: Encodable {
  
  public enum CodingKeys: String, CodingKey {
    case data       = "data"
  }
  
  public let data: ParameterData
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(data, forKey: .data)
  }
  
  public func makeJsonData() -> Data? {
    let jsonData = try? JSONEncoder().encode(self)
    return jsonData
  }
  
  public init(keyName: String,
              keyValue: String,
              deviceName: String,
              deviceType: String,
              userAgent: String)
  {
    self.data = ParameterData(keyName: keyName,
                              keyValue: keyValue,
                              deviceName: deviceName,
                              deviceType: deviceType,
                              userAgent: userAgent)
  }
}

extension DeviceData {
  
  public struct ParameterData: Encodable {
    
    public enum CodingKeys: String, CodingKey {
      case type       = "type"
      case id         = "id"
      case attributes = "attributes"
    }
    
    public let type = "devices"
    public let id   = UIDevice.current.identifierForVendor?.uuidString
    public let attributes: Attributes
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(type, forKey: .type)
      try container.encode(id, forKey: .id)
      try container.encode(attributes, forKey: .attributes)
    }
    
    public init(keyName: String,
         keyValue: String,
         deviceName: String,
         deviceType: String,
         userAgent: String)
    {
      self.attributes = Attributes(keyName: keyName,
                                   keyValue: keyValue,
                                   deviceName: deviceName,
                                   deviceType: deviceType,
                                   userAgent: userAgent)
    }
  }
  
}

extension DeviceData.ParameterData {
  
  public struct Attributes: Encodable {
    
    public enum CodingKeys: String, CodingKey {
      case name       = "name"
      case deviceType = "device_type"
      case userAgent  = "user_agent"
      case key        = "key"
    }
    
    public let name: String
    public let deviceType: String
    public let userAgent: String
    public let key: Key
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(name, forKey: .name)
      try container.encode(deviceType, forKey: .deviceType)
      try container.encode(userAgent, forKey: .userAgent)
      try container.encode(key, forKey: .key)
    }
    
    public init(keyName: String,
         keyValue: String,
         deviceName: String,
         deviceType: String,
         userAgent: String)
    {
      self.name = deviceName
      self.deviceType = deviceType
      self.userAgent = userAgent
      self.key = Key(keyName: keyName, keyValue: keyValue)
    }
  }
}
extension DeviceData.ParameterData.Attributes {
  
  public struct Key: Encodable {
    
    public enum CodingKeys: String, CodingKey {
      case algorithm = "algorithm"
      case name      = "name"
      case value     = "value"
      
    }
    
    public let algorithm = "http://www.w3.org/2001/04/xmlenc#rsa-1_5"
    public let name: String
    public let value: String
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(algorithm, forKey: .algorithm)
      try container.encode(name, forKey: .name)
      try container.encode(value, forKey: .value)
    }
    
    public init(keyName: String, keyValue: String) {
      self.name  = keyName
      self.value = keyValue
    }
  }
}

