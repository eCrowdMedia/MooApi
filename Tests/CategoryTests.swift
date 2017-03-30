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
    
    guard let category = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    let attributes = category.attributes
    let relationships = category.relationships
    let links = category.links

    // Test type and id
    XCTAssertEqual(category.type, "categories")
    XCTAssertEqual(category.id, "182")

    // Test attributes
    XCTAssertEqual(attributes.name, "財經企管")

    // Test relationships
    XCTAssertEqual(relationships.parent?.type, "categories")
    XCTAssertEqual(relationships.parent?.id, "181")

    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/categories/182")

    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }

    XCTAssertEqual(inclusion.categories.count, 2)
  }
  
}
