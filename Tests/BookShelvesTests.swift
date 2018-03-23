import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class BookShelvesTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookshelvesInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Bookshelf>.decode(json)

    // Test data
    guard let bookshelf = result.value?.data else {
      XCTFail("\(result.error.debugDescription)")
      return
    }

    do {
      let attributes = bookshelf.attributes
      let relationships = bookshelf.relationships
      let links = bookshelf.links
      
      // Test type and id
      XCTAssertEqual(bookshelf.type, "library_items")
      XCTAssertEqual(bookshelf.id, "1022197")

      // Test attributes
      XCTAssertEqual(attributes.isNew, false)
      XCTAssertEqual(attributes.privacy, "everyone")
      XCTAssertEqual(attributes.isArchive, false)
      XCTAssertEqual(attributes.isSubscribable, false)
      XCTAssertEqual(attributes.policy?.type, "ticket")
      XCTAssertEqual(attributes.policy?.permissions.isEmpty, true)
      XCTAssertEqual(attributes.policy?.prohibitions.isEmpty, false)

      // Test relationships
      XCTAssertEqual(relationships.reading.type, "readings")
      XCTAssertEqual(relationships.reading.id, "784752")

      // Test links
      XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/library/books/1022197")
      XCTAssertEqual(links.reader, "https://readmoo.com/api/reader/210068285000101")
      XCTAssertEqual(links.toc, "https://cdn.readmoo.com/book/toc/full/210068285000101.json")
    }

    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(inclusion.publishers.isEmpty, false)
    XCTAssertEqual(inclusion.contributors.isEmpty, false)
    XCTAssertEqual(inclusion.books.isEmpty, false)
    XCTAssertEqual(inclusion.readings.isEmpty, false)
    XCTAssertEqual(inclusion.reviews.isEmpty, true)
  }
  
}
