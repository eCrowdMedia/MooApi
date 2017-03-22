import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class MarathonTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "MarathonInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Marathon>.decode(json)
    
    guard let marathon = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = marathon.attributes
    let links = marathon.links

    // Test type and id
    XCTAssertEqual(marathon.type, "marathons")
    XCTAssertEqual(marathon.id, "american2017")
    
    // Test attributes
    XCTAssertEqual(attributes.name, "美國主題書單馬拉松")
    XCTAssertEqual(attributes.marathonDescription, "閱讀世界踩點任務：美國")
    XCTAssertEqual(attributes.startedAt, "2017-03-14T16:00:00Z")
    XCTAssertEqual(attributes.endedAt, "2017-04-16T16:00:00Z")

    // test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/marathons/american2017")
    XCTAssertEqual(links.publications, "https://api.readmoo.com/read/v2/me/library/publications?filter%5Bmarathon%5D=american2017")
    XCTAssertEqual(links.site, "https://readmoo.com/campaign/2017/3/world_arround_america/index")
  }
  
}
