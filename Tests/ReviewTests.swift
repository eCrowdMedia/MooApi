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
      XCTFail()
      return
    }

    let attributes = review.attributes
    let relationships = review.relationships
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
    XCTAssertEqual(attributes.lastestModifiedAt, "2017-03-07T10:29:29Z")

    // Test relationships
    XCTAssertEqual(relationships.book.data?.type, "books")
    XCTAssertEqual(relationships.book.data?.id, "210060444000101")
    XCTAssertEqual(relationships.reading.data?.type, "readings")
    XCTAssertEqual(relationships.reading.data?.id, "800409")
    
    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/reviews/1971")

    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail("no included data")
      return
    }

    XCTAssertEqual(inclusion.publishers.count, 1)
    XCTAssertEqual(inclusion.contributors.isEmpty, false)
    XCTAssertEqual(inclusion.categories.isEmpty, false)
    XCTAssertEqual(inclusion.books.count, 1)
    XCTAssertEqual(inclusion.readings.count, 1)
  }
  
}
