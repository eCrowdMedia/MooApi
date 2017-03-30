import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class CommentTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "CommentInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Comment>.decode(json)
    
    guard result.error == nil else {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    guard let comment = result.value?.data else {
      XCTFail()
      return
    }
    
    let attributes = comment.attributes
    let relationships = comment.relationships
    let links = comment.links
    
    // Test type and id
    XCTAssertEqual(comment.type, "comments")
    XCTAssertEqual(comment.id, "111")
    
    // Test attributes
    XCTAssertEqual(attributes.content, "夏丏尊對教育發出的喟嘆，過了五十年再看，我們似乎仍然未跳出窠臼。")
    XCTAssertEqual(attributes.postedAt, "2012-09-14T21:54:42Z")
    
    // Test relationships
    XCTAssertNil(relationships.replyTo)

    XCTAssertEqual(relationships.commentator.type, "users")
    XCTAssertEqual(relationships.commentator.id, "bb7a74k84")

    XCTAssertEqual(relationships.highlight.related, "https://api.readmoo.com/read/v2/comments/111/highlight")

    XCTAssertNil(relationships.review)
    
    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/comments/111")
    
    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(inclusion.users.count, 1)
  }
  
}
