import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class DocumentTests: XCTestCase {
  
  func testParsing() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "DocumentInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Document>.decode(json)
    
    // Test data
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
    }
    
    if result.value?.data.attributes == nil {
      XCTFail("\(result.error.debugDescription)")
    }
    
  }
    
}
