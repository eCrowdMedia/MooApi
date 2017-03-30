import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class ReviewTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "ReviewInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Review>.decode(json)
    
    guard let review = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    let attributes = review.attributes
    let links = review.links

    // Test type and id
    XCTAssertEqual(review.type, "reviews")
    XCTAssertEqual(review.id, "1971")

    // Test attributes
    XCTAssertEqual(attributes.privacy, "everyone")
    XCTAssertEqual(attributes.title, "")
    XCTAssertEqual(attributes.content, "好看")
    XCTAssertEqual(attributes.commentsCount, 0)
    XCTAssertEqual(attributes.likesCount, 0)
    XCTAssertEqual(attributes.createdAt, "2017-03-07T10:29:04Z")
    XCTAssertEqual(attributes.latestModifiedAt, "2017-03-07T10:29:29Z")

    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/reviews/1971")
  }
  
}
