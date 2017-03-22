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
      XCTFail()
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
    XCTAssertEqual(relationships.book.data?.type, "books")
    XCTAssertEqual(relationships.book.data?.id, "210010466000101")

    XCTAssertEqual(relationships.user.data?.type, "users")
    XCTAssertEqual(relationships.user.data?.id, "lljl9jqlh")

    XCTAssertEqual(relationships.reading.data?.type, "readings")
    XCTAssertEqual(relationships.reading.data?.id, "51924")

    XCTAssertEqual(relationships.path.data?.type, "paths")
    XCTAssertEqual(relationships.path.data?.id, "116445")
    
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
