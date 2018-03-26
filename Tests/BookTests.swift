import XCTest
@testable import MooApi
import Argo

final internal class BookTests: XCTestCase {

  func testBookModel() {
    
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "BookInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Book>.decode(json)
    
    guard (result.value?.data) != nil else {
      XCTFail("\(result.error!)")
      return
    }
    
    guard (result.value?.included) != nil else {
      XCTFail("\(result.error!)")
      return
    }
    
  }
  
}
