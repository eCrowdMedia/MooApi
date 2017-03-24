import XCTest
@testable import MooApi
import Argo
import Foundation

final internal class SubscriptionTests: XCTestCase {
  
  func testDatas() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "SubscriptionInfo", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
    let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
    let result = ApiDocument<Subscription>.decode(json)

    guard let subscription = result.value?.data else {
      XCTFail()
      return
    }

    let attributes = subscription.attributes
    let relationships = subscription.relationships
    let links = subscription.links

    // Test type and id
    XCTAssertEqual(subscription.type, "subscriptions")
    XCTAssertEqual(subscription.id, "185")

    // Test attributes
    XCTAssertEqual(attributes.name, "NOVA情報誌")
    XCTAssertEqual(attributes.period, "P1M")
    XCTAssertEqual(attributes.content, "<p>NOVA情報誌針對消費者採購行為設計的編輯欄目，透過What-Where-How的閱讀方式，讓您Smart Buy。每期超過8萬字的文字報導，搭配活潑圖代文編排，無論您是玩家還是新手，都能輕鬆享受閱讀樂趣！</p>\n")
    XCTAssertEqual(attributes.productType, "book")
    XCTAssertEqual(attributes.isAdultOnly, false)
    XCTAssertEqual(attributes.language, "zh-Hant")
    XCTAssertEqual(attributes.delivered, 11)
    XCTAssertEqual(attributes.remaining, 0)
    XCTAssertEqual(attributes.isAutoRenew, false)

    // Test relationships
    XCTAssertEqual(relationships.publisher.data?.type, "publishers")
    XCTAssertEqual(relationships.publisher.data?.id, "499")
    XCTAssertEqual(relationships.mainSubject.data?.type, "categories")
    XCTAssertEqual(relationships.mainSubject.data?.id, "184")
    XCTAssertEqual(relationships.bookshelves.data.count, 6)

    // Test links
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/me/library/subscriptions/185")
    XCTAssertEqual(links.site, "https://readmoo.com/mag/185")

    // Test inclusion
    guard let inclusion = result.value?.included else {
      XCTFail("no included data")
      return
    }

    XCTAssertEqual(inclusion.publishers.isEmpty, false)
    XCTAssertEqual(inclusion.categories.isEmpty, false)
    XCTAssertEqual(inclusion.books.isEmpty, false)
    XCTAssertEqual(inclusion.bookshelves.isEmpty, false)
    XCTAssertEqual(inclusion.readings.isEmpty, false)
    XCTAssertEqual(inclusion.contributors.isEmpty, false)
  }
  
}
