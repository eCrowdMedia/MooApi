import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class TagTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "TagData", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocumentEnvelope<Tag>.decode(json)
    
    // Test data
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
  }
  
}

