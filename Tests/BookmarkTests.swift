import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class BookmarkTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookmarkInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.Bookmark>.decode(json)
    
    guard let bookmark = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }
    
    let attributes = bookmark.attributes
    let relationships = bookmark.relationships
    let links = bookmark.links
    
    // Test type and id
    XCTAssertEqual(bookmark.type, "bookmarks")
    XCTAssertEqual(bookmark.id, "47600")
    
    // Test attributes
    XCTAssertEqual(attributes.bookmarkedAt, "2015-12-18T11:28:52Z")
    
    // Test relationships
    XCTAssertEqual(relationships.book.type, "books")
    XCTAssertEqual(relationships.book.id, "210010466000101")

    XCTAssertEqual(relationships.user.type, "users")
    XCTAssertEqual(relationships.user.id, "lljl9jqlh")

    XCTAssertEqual(relationships.reading.type, "readings")
    XCTAssertEqual(relationships.reading.id, "51924")

    XCTAssertEqual(relationships.path.type, "paths")
    XCTAssertEqual(relationships.path.id, "49107")
    
    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/bookmarks/47600")
    
    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(inclusion.books.isEmpty, false)
    XCTAssertEqual(inclusion.readings.isEmpty, false)
    XCTAssertEqual(inclusion.paths.isEmpty, false)
    XCTAssertEqual(inclusion.categories.isEmpty, false)
    XCTAssertEqual(inclusion.contributors.isEmpty, false)
    XCTAssertEqual(inclusion.publishers.isEmpty, false)
    XCTAssertEqual(inclusion.users.isEmpty, false)
  }
  
}
