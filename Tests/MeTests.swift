import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class MeTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "MeInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Me>.decode(json)
    
    guard (result.value?.data) != nil else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

  }
  
}
