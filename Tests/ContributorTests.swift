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
    let value = result.value?.data
    
    // Test all results
    XCTAssertNil(result.error)
    
    // Test data
    XCTAssertNotNil(value)
    XCTAssertEqual(value?.type, "contributors")
    XCTAssertEqual(value?.id, "20441")
    XCTAssertEqual(value?.name, "戴夫．卓特")
    XCTAssertEqual(value?.link, "https://api.readmoo.com/read/v2/contributors/20441")
  }
  
}
