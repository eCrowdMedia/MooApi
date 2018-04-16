import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class SubscriptionTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "SubscriptionInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocumentEnvelope<Subscription>.decode(json)

    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
  }
  
}
