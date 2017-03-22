import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class ReadingLogTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "ReadingLogInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<MooApi.ReadingLog>.decode(json)
 
    guard result.error == nil else {
      print("error: \(result.error.debugDescription)")
      XCTFail()
      return
    }
    
    guard let readingLog = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = readingLog.attributes
    let relationships = readingLog.relationships
    let links = readingLog.links

    // Test type and id
    XCTAssertEqual(readingLog.type, "readinglogs")
    XCTAssertEqual(readingLog.id, "3272563")
    
    // Test attributes
    XCTAssertEqual(attributes.identifier, "0035bc92-028b-11e7-93ae-92361f002671")
    XCTAssertEqual(attributes.cfi, "/6/12!/4/2/1:1")
    XCTAssertNil(attributes.chapter) // null
    XCTAssertEqual(attributes.duration, 5)
    XCTAssertEqual(attributes.progress, 0)
    XCTAssertEqual(attributes.touchedAt, "2016-19-12T03:16:25Z")
    XCTAssertEqual(attributes.userAgent, "string")
    XCTAssertNil(attributes.ip) // null
    XCTAssertNil(attributes.latitude) // null
    XCTAssertNil(attributes.longitude) // null

    // Test relationships
    XCTAssertEqual(relationships.event.data?.type, "events")
    XCTAssertEqual(relationships.event.data?.id, "7")
    XCTAssertEqual(relationships.event.links?.related, "https://api.readmoo.com/read/v2/me/readinglogs/3272563/event")

    XCTAssertEqual(relationships.parent.data?.type, "readinglogs")
    XCTAssertEqual(relationships.parent.data?.id, "629017")
    XCTAssertEqual(relationships.parent.links?.related, "https://api.readmoo.com/read/v2/me/readinglogs/3272563/parent")

    XCTAssertEqual(relationships.reading.data?.type, "readings")
    XCTAssertEqual(relationships.reading.data?.id, "51924")
    XCTAssertEqual(relationships.reading.links?.related, "https://api.readmoo.com/read/v2/me/readinglogs/3272563/reading")

    // test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/readinglogs/3272563")
  }
  
}
