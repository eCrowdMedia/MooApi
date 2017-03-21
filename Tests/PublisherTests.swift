// import XCTest
// @testable import MooApi
// import Argo
// import Foundation

// final internal class PublisherTests: XCTestCase {
  
//   func testDatas() {
//     let testBundle = Bundle(for: type(of: self))
//     let path = testBundle.path(forResource: "PublisherInfo", ofType: "json")
//     let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//     let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
//     let result = ApiDocument<MooApi.Publisher>.decode(json)
//     let value = result.value?.data
    
//     // Test all results
//     XCTAssertNil(result.error)
    
//     // Test data
//     XCTAssertNotNil(value)
//     XCTAssertEqual(value?.type, "publishers")
//     XCTAssertEqual(value?.id, "111")
//     XCTAssertEqual(value?.name, "iFit 愛瘦身")
//     XCTAssertEqual(value?.link, "https://api.readmoo.com/read/v2/publishers/111")
//   }
  
// }
