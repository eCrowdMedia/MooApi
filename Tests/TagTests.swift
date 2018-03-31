import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class TagTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "TagData", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    
    // Test data
    do {
      _ = try JSONDecoder().decode(TagResponse.self, from: data)
    } catch {
      XCTFail(error.localizedDescription)
    }
    
  }
  
}

