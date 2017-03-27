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
    
    // Test all results
    XCTAssertNil(result.error)

    // Test data
    guard let bookshelf = result.value?.data else {
      XCTFail()
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
      XCTAssertEqual(attributes.conditions?.before, "2016-04-21T16:00:00Z")
      XCTAssertEqual(attributes.conditions?.after, "2016-04-21T16:00:00Z")
      XCTAssertEqual(attributes.createdAt, "2016-04-21T16:00:00Z")
      XCTAssertEqual(attributes.touchedAt, "2016-04-21T16:00:00Z")

      // Test relationships
      XCTAssertEqual(relationships.book.data?.type, "books")
      XCTAssertEqual(relationships.book.data?.id, "210068285000101")
      XCTAssertEqual(relationships.reading.data?.type, "readings")
      XCTAssertEqual(relationships.reading.data?.id, "784752")

      // Test links
      XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/library/books/1022197")
      XCTAssertEqual(links.reader, "https://readmoo.com/api/reader/210068285000101")
      XCTAssertEqual(links.epub, "https://api.readmoo.com/epub/210068285000101")
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
