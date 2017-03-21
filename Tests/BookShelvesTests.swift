// import XCTest
// @testable import MooApi
// import Argo
// import Foundation

// final internal class BookShelvesTests: XCTestCase {
  
//   func testDatas() {
//     let testBundle = Bundle(for: type(of: self))
//     let path = testBundle.path(forResource: "BookshelvesInfo", ofType: "json")
//     let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//     let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
//     let result = ApiDocumentEnvelope<Bookshelf>.decode(json)
    
//     // Test all results
//     XCTAssertNil(result.error)
    
//     // Test meta
//     let meta = result.value?.meta
//     XCTAssertEqual(meta?.totalCount, 2335)
//     XCTAssertEqual(meta?.page?.count, 1)
//     XCTAssertEqual(meta?.page?.offset, 0)
    
//     // Test pagination links
//     let paginationLinks = result.value?.paginationLinks
//     XCTAssertEqual(paginationLinks?.selfLink, "https://api.readmoo.com/read/v2/me/library/books?page%5Bcount%5D=1&page%5Boffset%5D=0")
//     XCTAssertEqual(paginationLinks?.next, "https://api.readmoo.com/read/v2/me/library/books?page%5Bcount%5D=1&page%5Boffset%5D=1")
//     XCTAssertEqual(paginationLinks?.last, "https://api.readmoo.com/read/v2/me/library/books?page%5Bcount%5D=1&page%5Boffset%5D=2334")

//     // Test data
//     guard let values = result.value?.data else {
//       XCTFail()
//       return
//     }
    
//     XCTAssertEqual(values.count, 1)
    
//     // Test index 0
//     do {
//       let bs = values[0]
//       let attributes = bs.attributes
//       let relationships = bs.relationships
//       XCTAssertEqual(bs.type, "library_items")
//       XCTAssertEqual(bs.id, "1040336")
//       XCTAssertEqual(attributes.action, "download")
//       XCTAssertEqual(attributes.isNew, false)
//       XCTAssertEqual(attributes.privacy.rawValue, "everyone")
//       XCTAssertEqual(attributes.isArchive, false)
//       XCTAssertEqual(attributes.isSubscribable, false)
//       XCTAssertEqual(relationships.book?.type, "books")
//       XCTAssertEqual(relationships.book?.id, "210068261000101")
//       XCTAssertEqual(relationships.reading?.type, "readings")
//       XCTAssertEqual(relationships.reading?.id, "799716")
//       XCTAssertEqual(bs.links.selfLink, "https://api.readmoo.com/read/v2/me/library/books/1035877")
//       XCTAssertEqual(bs.links.reader, "https://readmoo.com/api/reader/210068261000101")
//       XCTAssertEqual(bs.links.epub, "https://api.readmoo.com/epub/210068261000101")
//       XCTAssertEqual(bs.links.toc, "https://cdn.readmoo.com/book/toc/full/210068261000101.json")
//     }
    
//     // Test to check is not empty
//     do {
//       for bs in values {
//         XCTAssertNotEqual(bs.type, "")
//         XCTAssertNotEqual(bs.id, "")
//         XCTAssertNotEqual(bs.action, "")
//         XCTAssertNotEqual(bs.privacy.rawValue, "")
//         XCTAssertNotEqual(bs.book?.type, "")
//         XCTAssertNotEqual(bs.book?.id, "")
//         XCTAssertNotEqual(bs.reading?.type, "")
//         XCTAssertNotEqual(bs.reading?.id, "")
//         XCTAssertNotEqual(bs.links.selfLink, "")
//         XCTAssertNotEqual(bs.links.reader, "")
//         XCTAssertNotEqual(bs.links.epub, "")
//         XCTAssertNotEqual(bs.links.toc, "")
//       }
//     }
    
//     // Test included
//     guard let inclusion = result.value?.included else {
//       XCTFail()
//       return
//     }
    
//     XCTAssertEqual(inclusion.publishers.count, 28)
//     XCTAssertEqual(inclusion.books.count, 48)
//     XCTAssertEqual(inclusion.readings.count, 48)
//     XCTAssertEqual(inclusion.reviews.count, 0) // review privacy should ask server again
//   }
  
// }
