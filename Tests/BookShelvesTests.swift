import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class BookShelvesTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookshelvesInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Bookshelf>.decode(json)

    // Test data
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }

  }
  
  func testBookShelves() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookshelvesData", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocumentEnvelope<Bookshelf>.decode(json)
    
    // Test data
    if result.value?.data == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    if result.value?.included == nil {
      XCTFail("\(result.error.debugDescription)")
      return
    }
  }
  
}
