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
  public let accessToken: String
  public let parameters: [String: String]?
  
  public init(_ method: ServiceMethod, url: URL, accessToken: String, parameters: [String: String]? = nil) {
    self.url = url
    self.method = method
    self.accessToken = accessToken
    self.parameters = parameters
  }
  
  public init(_ method: ServiceMethod, api: ServiceApi, accessToken: String, parameters: [String: String]? = nil) {
    self.url = URL(string: api.baseURL + api.path)!
    self.method = method
    self.accessToken = accessToken
    self.parameters = nil
  }
  
  public var request: URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = method.rawValue
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    httpHeaders.forEach { (dict) in
      let headerField = dict.key
      let headerValue = dict.value
      request.setValue(headerValue, forHTTPHeaderField: headerField)
    }
    
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
  
  public func fetchJSONModel<T: Argo.Decodable>(
    completion: @escaping (Result<ApiDocument<T>, ServiceError>) -> Void)
    where T == T.DecodedType
  {
    DispatchQueue.global(qos: .utility).async {
      let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
        guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
          completion(.failure(ServiceError.network(error: error!)))
          return
        }
        
        let statusCode = httpResponse.statusCode
        
        guard 200..<300 ~= statusCode else {
          completion(.failure(ServiceError.serverError(statusCode: statusCode, data: data)))
          return
        }
        
        do {
          let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          let decodedObject = ApiDocument<T>.decode(JSON(jsonObject))
          
          guard let value = decodedObject.value else {
            completion(.failure(ServiceError.decodedError(error: decodedObject.error!)))
            return
          }
          
          completion(.success(value))
          
        } catch {
          completion(.failure(ServiceError.serializeJSON(error: error)))
        }
      }
      
      task.resume()
    }
  }
  
  public func fetchJSONModels<T: Argo.Decodable>(
    completion: @escaping (Result<ApiDocumentEnvelope<T>, ServiceError>) -> Void)
    where T == T.DecodedType
  {
    DispatchQueue.global(qos: .utility).async {
      let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
        guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
          completion(.failure(ServiceError.network(error: error!)))
          return
        }
        
        let statusCode = httpResponse.statusCode
        
        guard 200..<300 ~= statusCode else {
          completion(.failure(ServiceError.serverError(statusCode: statusCode, data: data)))
          return
        }
        
        do {
          let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          let decodedObject = ApiDocumentEnvelope<T>.decode(JSON(jsonObject))
          
          guard let value = decodedObject.value else {
            completion(.failure(ServiceError.decodedError(error: decodedObject.error!)))
            return
          }
          
          completion(.success(value))
          
        } catch {
          completion(.failure(ServiceError.serializeJSON(error: error)))
        }
      }
      
      task.resume()
    }
  }
  
}
