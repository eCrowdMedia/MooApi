import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class TagTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "TagData", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let result = try? JSONDecoder().decode(TagResponse.self, from: data )
    
    XCTAssertNotNil(result, "no result, parse failure")
    XCTAssertFalse(result?.data.count == 0, "no result data")
    XCTAssertNotNil(result?.included)
    XCTAssertNotNil(result?.data.first?.type)
    XCTAssertNotNil(result?.data.first?.id)
    XCTAssertNotNil(result?.data.first?.attributes)
    XCTAssertNotNil(result?.data.first?.links)
    XCTAssertTrue(result?.data.first?.attributes.name == "舞林秘笈")
    
  }
  
}

