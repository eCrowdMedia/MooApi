// import XCTest
// @testable import MooApi
// import Argo
// import Foundation

// final internal class ReadingTests: XCTestCase {
  
//   func testDatas() {
//     let testBundle = Bundle(for: type(of: self))
//     let path = testBundle.path(forResource: "ReadingInfo", ofType: "json")
//     let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//     let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
//     let result = ApiDocument<Reading>.decode(json)
//     let value = result.value?.data
    
//     // Test all results
//     XCTAssertNil(result.error)
//     XCTAssertNil(result.value?.meta)
//     XCTAssertNil(result.value?.paginationLinks)
    
//     // Test data
//     XCTAssertNotNil(value)
//     XCTAssertEqual(value?.type, "readings")
//     XCTAssertEqual(value?.id, "51924")
//     XCTAssertEqual(value?.state.rawValue, "finished")
//     XCTAssertEqual(value?.privacy.rawValue, "everyone")
//     XCTAssertEqual(value?.startedAt, "2013-12-12T03:55:14Z")
//     XCTAssertEqual(value?.touchedAt, "2017-03-13T08:35:12Z")
//     XCTAssertEqual(value?.endedAt, "2015-12-15T07:33:23Z")
//     XCTAssertEqual(value?.duration, 60840)
//     XCTAssertEqual(value?.progress, 0)
//     XCTAssertEqual(value?.commentsCount, 1)
//     XCTAssertEqual(value?.highlightedCount, 11)
//     XCTAssertEqual(value?.position, 0)
//     XCTAssertEqual(value?.positionUpdatedAt, "2017-03-13T08:35:12Z")
//     XCTAssertEqual(value?.location, "/6/4!/4/10/1:1")
//     XCTAssertEqual(value?.rating, 5)
//     XCTAssertEqual(value?.book?.type, "books")
//     XCTAssertEqual(value?.book?.id, "210010466000101")
//     XCTAssertEqual(value?.review?.type, .none)
//     XCTAssertEqual(value?.review?.id, .none)
//     XCTAssertEqual(value?.links, "https://api.readmoo.com/read/v2/me/readings/51924")
    
//     // Test included
//     guard let inclusion = result.value?.included else {
//       XCTFail("no included data")
//       return
//     }
//     do {
//       XCTAssertEqual(inclusion.publishers.count, 1)
      
//       let p = inclusion.publishers[0]
//       XCTAssertEqual(p.type, "publishers")
//       XCTAssertEqual(p.id, "147")
//       XCTAssertEqual(p.name, "遠景")
//       XCTAssertEqual(p.link, "https://api.readmoo.com/read/v2/publishers/147")
//     }
    
//     XCTAssertEqual(inclusion.contributors.count, 1)
//     XCTAssertEqual(inclusion.books.count, 1)
//   }
  
// }
