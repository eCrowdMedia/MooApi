import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class ContributorTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "ContributorInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Contributor>.decode(json)
    
    
    if result.error != nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    if result.value?.data.attributes == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
  }
  
}
