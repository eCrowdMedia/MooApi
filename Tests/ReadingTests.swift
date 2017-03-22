import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class ReadingTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "ReadingInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Reading>.decode(json)
    
    guard let reading = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = reading.attributes
    let relationships = reading.relationships
    let links = reading.links

    // Test type and id
    XCTAssertEqual(reading.type, "readings")
    XCTAssertEqual(reading.id, "51924")

    // Test attributes
    XCTAssertEqual(attributes.state, "finished")
    XCTAssertEqual(attributes.privacy, "everyone")
    XCTAssertEqual(attributes.startedAt, "2013-12-12T03:55:14Z")
    XCTAssertEqual(attributes.touchedAt, "2016-12-19T03:16:25Z")
    XCTAssertEqual(attributes.endedAt, "2015-12-15T07:33:23Z")
    XCTAssertEqual(attributes.duration, 61140)
    XCTAssertEqual(attributes.progress, 0.12)
    XCTAssertEqual(attributes.commentsCount, 1)
    XCTAssertEqual(attributes.highlightedCount, 11)
    XCTAssertEqual(attributes.position, 0.12)
    XCTAssertEqual(attributes.positionUpdatedAt, "2016-12-19T03:16:25Z")
    XCTAssertEqual(attributes.location, "/6/12!/4/2/1:1")
    XCTAssertEqual(attributes.rating, 5)

    // Test relationships
    XCTAssertEqual(relationships.book.data?.type, "books")
    XCTAssertEqual(relationships.book.data?.id, "210010466000101")
    
    XCTAssertEqual(relationships.bookmarks.links?.related, "https://api.readmoo.com/read/v2/me/readings/51924/bookmarks")
    
    XCTAssertEqual(relationships.highlights.links?.related, "https://api.readmoo.com/read/v2/me/readings/51924/highlights")
    
    XCTAssertNil(relationships.review.data)

    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/readings/51924")
    
    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail("no included data")
      return
    }

    XCTAssertEqual(inclusion.publishers.count, 1)
    XCTAssertEqual(inclusion.contributors.count, 1)
    XCTAssertEqual(inclusion.categories.count, 2)
    XCTAssertEqual(inclusion.books.count, 1)
  }
  
}
