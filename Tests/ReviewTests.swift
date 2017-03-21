// import XCTest
// @testable import MooApi
// import Argo
// import Foundation

// final internal class ReviewTests: XCTestCase {
  
//   func testDatas() {
//     let testBundle = Bundle(for: type(of: self))
//     let path = testBundle.path(forResource: "ReviewInfo", ofType: "json")
//     let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//     let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
//     let result = ApiDocument<Review>.decode(json)
//     let value = result.value?.data
    
//     // Test all results
//     XCTAssertNil(result.error)
    
//     // Test data
//     XCTAssertNotNil(value)
//     XCTAssertEqual(value?.type, "reviews")
//     XCTAssertEqual(value?.id, "1971")
//     XCTAssertEqual(value?.privacy.rawValue, "everyone")
//     XCTAssertEqual(value?.title, "")
//     XCTAssertEqual(value?.content, "好看")
//     XCTAssertEqual(value?.commentsCount, 0)
//     XCTAssertEqual(value?.likesCount, 0)
//     XCTAssertEqual(value?.createdAt, "2017-03-07T10:29:04Z")
//     XCTAssertEqual(value?.lastestModifiedAt, "2017-03-07T10:29:29Z")
//     XCTAssertEqual(value?.book?.type, "books")
//     XCTAssertEqual(value?.book?.id, "210060444000101")
//     XCTAssertEqual(value?.link, "https://api.readmoo.com/read/v2/me/reviews/1971")
//   }
  
// }
