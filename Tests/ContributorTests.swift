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
    
    
    guard let contributor = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = contributor.attributes
    let links = contributor.links

    // Test type and id
    XCTAssertEqual(contributor.type, "contributors")
    XCTAssertEqual(contributor.id, "20441")

    // Test attributes
    XCTAssertEqual(attributes.name, "戴夫．卓特")

    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/contributors/20441")
  }
  
}
