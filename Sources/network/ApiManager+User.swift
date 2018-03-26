import Foundation
import Argo
import Result

extension ApiManager {
  
  public class OAuthApi {
    ///使用帳密獲取使用者的 Token
    public static func getToken(accountData: AccountData,
                                isDevelopment: Bool = false,
                                failure: @escaping (ServiceError) -> Void,
                                success: @escaping (String) -> Void)
    {
      
      guard let optionalBody = accountData.makeJsonData(),
        let auth = accountData.makeAuthorization() else {
          failure(ServiceError.apiBodyDataNotFound)
          return
      }
      
      let service = Service(ServiceMethod.post,
                            api: MemberApi.oauthToken,
                            authorization: auth,
                            parameters: nil,
                            httpBody: optionalBody,
                            isDevelopment: isDevelopment)
      
      
      service.fetchJSONRaw(with: service.oauthRequest, queue: nil) { (json, error) in
        if error != nil {
          failure(error!)
          return
        }
        
        guard let dic = json as? Dictionary<String, Any>,
          let token = dic["access_token"] as? String else
        {
          failure(ServiceError.serializeJSONFailed)
          return
        }
        success(token)
        
      }
    }
  }
  
  public class MeApi {
    
    ///取得使用者的相關資訊
    public static func getMe(auth: Authorization,
                             isDevelopment: Bool = false,
                             failure: @escaping (ServiceError) -> Void,
                             success: @escaping (Me) -> Void)
    {
      let service = Service(ServiceMethod.get,
                            api: ServiceApi.me,
                            authorization: auth,
                            parameters: nil,
                            isDevelopment: isDevelopment)
      
      service.fetchJSONModel(queue: nil) { (result: Result<ApiDocument<Me>, ServiceError>) in
        switch result {
        case .failure(let error):
          failure(error)
        case .success(let value):
          success(value.data)
        }
      }
      
    }
    
    public static func putDeviceId(auth: Authorization,
                                   deviceData: DeviceData,
                                   uuid: String,
                                   isDevelopment: Bool = false,
                                   failure: @escaping (ServiceError) -> Void,
                                   success: @escaping () -> Void)
    {
      guard let jsonData = deviceData.makeJsonData() else {
        failure(ServiceError.apiBodyDataNotFound)
        return
      }
      
      let service = Service(ServiceMethod.put,
                            api: ServiceApi.putMeDevices(deviceId: uuid),
                            authorization: auth,
                            parameters: nil,
                            httpBody: jsonData,
                            isDevelopment: isDevelopment)
      
      service.fetchJSONRaw(with: service.request, queue: nil, completion: { (json, error) in
        if error != nil {
          failure(error!)
          return
        }
        success()
      })
    }
    
  }
}
