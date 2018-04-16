import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class BookmarkTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookmarkInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Bookmark>.decode(json)
    
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    if result.value?.data.attributes == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    if result.value?.data.relationships == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
  }
  
}
