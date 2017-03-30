import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class MeTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "MeInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Me>.decode(json)
    
    guard let me = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    let attributes = me.attributes
    let links = me.links

    // Test type and id
    XCTAssertEqual(me.type, "me")
    XCTAssertEqual(me.id, "lljl9jqlh")
    
    // Test attributes
    XCTAssertEqual(attributes.nickname, "moo小編")
    XCTAssertEqual(attributes.email, "editor@readmoo.com")
    XCTAssertEqual(attributes.activateStatus, "activated")
    XCTAssertEqual(attributes.isDeviceAccount, false)

    // test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me")
    XCTAssertEqual(links.smallImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_40.png?v=1489027839")
    XCTAssertEqual(links.smallImage.width, 40)
    XCTAssertEqual(links.smallImage.resize, "crop")

    XCTAssertEqual(links.mediumImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_130.png?v=1489027839")
    XCTAssertEqual(links.mediumImage.width,130)
    XCTAssertEqual(links.mediumImage.resize, "crop")

    XCTAssertEqual(links.largeImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_200.png?v=1489027839")
    XCTAssertEqual(links.largeImage.width, 200)
    XCTAssertEqual(links.largeImage.resize, "crop")

  }
  
}
