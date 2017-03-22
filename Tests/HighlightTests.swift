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
      print("HighlightTests error: \(result.error.debugDescription)")
      XCTFail()
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
    XCTAssertEqual(highlight.id, "200197")
    
    // Test attributes
    XCTAssertEqual(attributes.privacy, "everyone")
    XCTAssertEqual(attributes.commentsCount, 0)
    XCTAssertEqual(attributes.likesCount, 0)
    XCTAssertEqual(attributes.highlightedAt, "2017-01-04T02:58:25Z")

    // Test relationships
    XCTAssertEqual(relationships.book.data?.type, "books")
    XCTAssertEqual(relationships.book.data?.id, "210010466000101")

    XCTAssertEqual(relationships.reading.data?.type, "readings")
    XCTAssertEqual(relationships.reading.data?.id, "51924")

    XCTAssertEqual(relationships.range.data?.type, "ranges")
    XCTAssertEqual(relationships.range.data?.id, "307378")

    XCTAssertEqual(relationships.comments.links?.related, "https://api.readmoo.com/read/v2/me/highlights/200197/comments")

    XCTAssertEqual(relationships.user.data?.type, "users")
    XCTAssertEqual(relationships.user.data?.id, "lljl9jqlh")

    // test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/highlights/200197")

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
