import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class CategoryTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "CategoryInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Category>.decode(json)
    let value = result.value?.data
    
    // Test all results
    XCTAssertNil(result.error)
    XCTAssertNil(result.value?.meta)
    XCTAssertNil(result.value?.paginationLinks)
    XCTAssertNotNil(result.value?.included)
    
    // Test data
    XCTAssertNotNil(value)
    XCTAssertEqual(value?.type, "categories")
    XCTAssertEqual(value?.id, "182")
    XCTAssertEqual(value?.name, "財經企管")
    XCTAssertEqual(value?.parent?.type, "categories")
    XCTAssertEqual(value?.parent?.id, "181")
    XCTAssertEqual(value?.link, "https://api.readmoo.com/read/v2/categories/182")
  }
  
}
