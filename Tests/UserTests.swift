import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class UserTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "UserInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.User>.decode(json)
    
    guard let user = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    let attributes = user.attributes

    // Test type and id
    XCTAssertEqual(user.type, "users")
    XCTAssertEqual(user.id, "lljl9jqlh")
    
    // Test attributes
    XCTAssertEqual(attributes.nickname, "moo小編")

  }
  
}
