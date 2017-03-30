import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class HighlightTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "HighlightInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Highlight>.decode(json)
 
    guard result.error == nil else {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    guard let highlight = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = highlight.attributes
    let relationships = highlight.relationships
    let links = highlight.links

    // Test type and id
    XCTAssertEqual(highlight.type, "highlights")
    XCTAssertEqual(highlight.id, "200194")
    
    // Test attributes
    XCTAssertEqual(attributes.privacy, "everyone")
    XCTAssertEqual(attributes.commentsCount, 0)
    XCTAssertEqual(attributes.likesCount, 0)
    XCTAssertEqual(attributes.highlightedAt, "2017-01-04T02:58:10Z")

    // Test relationships
    XCTAssertEqual(relationships.book.type, "books")
    XCTAssertEqual(relationships.book.id, "210010466000101")

    XCTAssertEqual(relationships.reading.type, "readings")
    XCTAssertEqual(relationships.reading.id, "51924")

    XCTAssertEqual(relationships.range.type, "ranges")
    XCTAssertEqual(relationships.range.id, "307375")

    XCTAssertEqual(relationships.comments.related, "https://api.readmoo.com/read/v2/me/highlights/200194/comments")

    XCTAssertEqual(relationships.user.type, "users")
    XCTAssertEqual(relationships.user.id, "lljl9jqlh")

    // test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/highlights/200194")

    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(inclusion.publishers.isEmpty, false)
    XCTAssertEqual(inclusion.contributors.isEmpty, false)
    XCTAssertEqual(inclusion.books.isEmpty, false)
    XCTAssertEqual(inclusion.readings.isEmpty, false)
    XCTAssertEqual(inclusion.ranges.isEmpty, false)
    XCTAssertEqual(inclusion.reviews.isEmpty, true)
  }
  
}
