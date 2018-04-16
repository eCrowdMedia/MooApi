import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class PublisherTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "PublisherInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Publisher>.decode(json)
    
    guard let publisher = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    let attributes = publisher.attributes

    // Test type and id
    XCTAssertEqual(publisher.type, "publishers")
    XCTAssertEqual(publisher.id, "111")
    
    // Test attributes
    XCTAssertEqual(attributes.name, "iFit 愛瘦身")

  }
  
}
