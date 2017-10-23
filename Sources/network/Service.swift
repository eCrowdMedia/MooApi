import Foundation
import Argo
import Result

public enum ServiceMethod: String {
  case get    = "GET"
  case post   = "POST"
  case patch  = "PATCH"
  case delete = "DELETE"
}

public struct Service {
  public let url: URL
  public let method: ServiceMethod
  public let authorization: Authorization
  public let parameters: [String: String]?
  public let httpBody: Data?
  
  public init(
    _ method: ServiceMethod,
    url: URL, 
    authorization: Authorization, 
    parameters: [String: String]? = nil,
    httpBody: Data? = nil)
  {
    self.url = url
    self.method = method
    self.authorization = authorization
    self.parameters = parameters
    self.httpBody = httpBody
  }
  
  public init(
    _ method: ServiceMethod,
    api: MemberApi,
    authorization: Authorization,
    parameters: [String: String]? = nil,
    httpBody: Data? = nil,
    isDevelopMent: Bool = false)
  {
    let baseURL = isDevelopMent ? api.developMemberURL : api.memberURL
    self.url = URL(string: baseURL + api.path)!
    self.method = method
    self.authorization = authorization
    self.parameters = parameters
    self.httpBody = httpBody
  }
  
  public init(
    _ method: ServiceMethod,
    api: ServiceApi,
    authorization: Authorization,
    parameters: [String: String]? = nil,
    httpBody: Data? = nil,
    isDevelopMent: Bool = false)
  {
    let baseURL = isDevelopMent ? api.developBaseURL : api.baseURL
    self.url = URL(string: baseURL + api.path)!
    self.method = method
    self.authorization = authorization
    self.parameters = parameters
    self.httpBody = httpBody
  }
  
  public var oauthRequest: URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = method.rawValue
    request.setValue(authorization.header.value, forHTTPHeaderField: authorization.header.field)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = httpBody
    return request
  }
  
  public var request: URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = method.rawValue
    request.setValue(authorization.header.value, forHTTPHeaderField: authorization.header.field)
    
    httpHeaders.forEach { (dict) in
      let headerField = dict.key
      let headerValue = dict.value
      request.setValue(headerValue, forHTTPHeaderField: headerField)
    }
    
    request.httpBody = httpBody
    return request
  }
  
  fileprivate var urlComponents: URLComponents {
    var urlComponents = URLComponents(string: url.absoluteString)!
    
    if let parameters = parameters {
      let queryItems = parameters.map { p -> URLQueryItem in
        return URLQueryItem(name: p.key, value: p.value)
      }
      urlComponents.queryItems = queryItems
    }
    
    return urlComponents
  }
  
  fileprivate var httpHeaders: [String: String] {
    switch method {
    case .get:
      return ["Accept": "application/vnd.api+json"]
    case .post:
      return ["Accept": "application/vnd.api+json", "Content-Type": "application/vnd.api+json"]
    case .patch:
      return ["Accept": "application/vnd.api+json", "Content-Type": "application/vnd.api+json"]
    case .delete:
      return ["Accept": "application/vnd.api+json", "Content-Type": "application/vnd.api+json"]
    }
  }
  
}

extension Service {
  
  public func fetchJSONRaw (
    queue: DispatchQueue?,
    completion: @escaping (Result<Any, ServiceError>) -> Void) {
    (queue ?? DispatchQueue.global(qos: .utility)).async {
      let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
        // Checking if network error
        guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
          completion(.failure(ServiceError.network(error: error!)))
          return
        }
        
        // Checking if json serialize error
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
          completion(.failure(.serializeJSONFailed))
          return
        }
        
        let statusCode = httpResponse.statusCode
        
        // Checking if server failed
        if statusCode >= 500 {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.serverFailedToReach(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api failed
        if 400 ..< 500 ~= statusCode {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.apiExecitionFailed(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api with successful response
        guard 200..<300 ~= statusCode else {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.invalidApi(statusCode: statusCode, reason: reason)))
          return
        }
        
        completion(.success(jsonObject))
      }
      
      task.resume()
    }
  }
  
  public func fetchJSONModel<T: Argo.Decodable>(
    queue: DispatchQueue?,
    completion: @escaping (Result<ApiDocument<T>, ServiceError>) -> Void)
    where T == T.DecodedType
  {
    (queue ?? DispatchQueue.global(qos: .utility)).async {
      let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
        // Checking if network error
        guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
          completion(.failure(ServiceError.network(error: error!)))
          return
        }

        // Checking if json serialize error
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
          completion(.failure(.serializeJSONFailed))
          return
        }
        
        let statusCode = httpResponse.statusCode

        // Checking if server failed
        if statusCode >= 500 {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.serverFailedToReach(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api failed
        if 400 ..< 500 ~= statusCode {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.apiExecitionFailed(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api with successful response
        guard 200..<300 ~= statusCode else {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.invalidApi(statusCode: statusCode, reason: reason)))
          return
        }

        do {
          let decodedObject = try ApiDocument<T>.decode(JSON(jsonObject)).dematerialize()
          completion(.success(decodedObject))
        } catch {
          // Checking if decoded result is null
          switch JSON(jsonObject) {
          case .null:
            completion(.failure(.dataNotExisted))
          default:
            completion(.failure(.decodedError(error as! DecodeError)))
          }
        }
      }
      
      task.resume()
    }
  }
  
  public func fetchJSONModels<T: Argo.Decodable>(
    queue: DispatchQueue?,
    completion: @escaping (Result<ApiDocumentEnvelope<T>, ServiceError>) -> Void)
    where T == T.DecodedType
  {
    (queue ?? DispatchQueue.global(qos: .utility)).async {
      let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
        // Checking if network error
        guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
          completion(.failure(ServiceError.network(error: error!)))
          return
        }
        
        // Checking if json serialize error
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
          completion(.failure(.serializeJSONFailed))
          return
        }
        
        let statusCode = httpResponse.statusCode
        
        // Checking if server failed
        if statusCode >= 500 {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.serverFailedToReach(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api failed
        if 400 ..< 500 ~= statusCode {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.apiExecitionFailed(statusCode: statusCode, reason: reason)))
          return
        }
        
        // Checking if api with successful response
        guard 200..<300 ~= statusCode else {
          let reason = try? ApiDocumentErrorEnvelope.decode(JSON(jsonObject)).dematerialize()
          completion(.failure(.invalidApi(statusCode: statusCode, reason: reason)))
          return
        }
        
        do {
          let decodedObject = try ApiDocumentEnvelope<T>.decode(JSON(jsonObject)).dematerialize()
          completion(.success(decodedObject))
        } catch {
          // Checking if decoded result is null
          switch JSON(jsonObject) {
          // Bug here
          case .array:
            completion(.failure(.dataNotExisted))
          default:
            completion(.failure(.decodedError(error as! DecodeError)))
          }
        }
      }
      
      task.resume()
    }
  }
  
}
