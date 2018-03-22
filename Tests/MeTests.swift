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

    // Test type and id
    XCTAssertEqual(me.type, "me")
    XCTAssertEqual(me.id, "lljl9jqlh")
    
    // Test attributes
    XCTAssertEqual(attributes.nickname, "moo小編")
    XCTAssertEqual(attributes.email, "editor@readmoo.com")
    XCTAssertEqual(attributes.activateStatus, "activated")
    XCTAssertEqual(attributes.isDeviceAccount, false)
    //Test Avatar
    let avatar = attributes.avatar
    XCTAssertEqual(avatar.smallImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_40.png?v=1520494335")
    XCTAssertEqual(avatar.smallImage.width, 40)
    XCTAssertEqual(avatar.smallImage.resize, "crop")
    
    XCTAssertEqual(avatar.mediumImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_130.png?v=1520494335")
    XCTAssertEqual(avatar.mediumImage.width, 130)
    XCTAssertEqual(avatar.mediumImage.resize, "crop")
    
    XCTAssertEqual(avatar.largeImage.href, "https://cdn.readmoo.com/avatar/ll/jl9jqlh_200.png?v=1520494335")
    XCTAssertEqual(avatar.largeImage.width, 200)
    XCTAssertEqual(avatar.largeImage.resize, "crop")
  }
  
}
