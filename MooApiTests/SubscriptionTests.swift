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
    let result = ApiDocumentEnvelope<Subscription>.decode(json)
    
    // Test all results
    XCTAssertNil(result.error)
    
    // Test meta
    let meta = result.value?.meta
    XCTAssertEqual(meta?.totalCount, 45)
    XCTAssertNil(meta?.page)
    
    // Test pagination links
    let paginationLinks = result.value?.paginationLinks
    XCTAssertNil(paginationLinks)
    
    // Test data
    guard let values = result.value?.data else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(values.count, 45)
    
    // Test index 4
    do {
      let subs = values[4]
      XCTAssertEqual(subs.type, "subscriptions")
      XCTAssertEqual(subs.id, "58")
      XCTAssertEqual(subs.name, "經理人月刊")
      XCTAssertEqual(subs.period, "P1M")
      XCTAssertEqual(subs.content, "<p>《經理人月刊》自2004年創刊以來，以「匯集全球智慧、萃取本土觀點、徹底解讀、即學即用」的角度，滿足經理人的各項管理需求、解除管理焦慮，時時刻刻補充知識養分，匯聚全台最大的經理人社群。</p>\r\n\r\n<p>■主題學習：每期拆解一主題，從理論架構、實務應用到精選案例，完整學習</p>\r\n\r\n<p>■管理在線：每期掃描15本國際商管期刊，15分鐘掌握全球管理新知</p>\r\n\r\n<p>■管理圖解：圖形化思考，一張圖等於一本管理書</p>\r\n\r\n<p>■實用祕技：擷取最新商管書籍的菁華，搜羅現學現用的觀念與做法</p>\r\n\r\n<p>■CEO管理講堂：專訪國內知名企業CEO，挖掘其成功之道</p>\r\n\r\n<p>■商業思想家：引介當代對管理思潮與趨勢提出突破性見解的重要商業思想家</p>\r\n\r\n<p>＊＊成功訂閱後，將由次月開始派送或接續您原訂閱期數＊＊</p>\r\n")
      XCTAssertEqual(subs.productType.rawValue, "book")
      XCTAssertEqual(subs.isAdulyOnly, false)
      XCTAssertEqual(subs.language.rawValue, "zh-Hant")
      XCTAssertEqual(subs.delivered, 13)
      XCTAssertEqual(subs.remaining, 0)
      XCTAssertEqual(subs.isAutoRenew, false)
      XCTAssertEqual(subs.publication?.type, "publishers")
      XCTAssertEqual(subs.publication?.id, "209")
      XCTAssertEqual(subs.mainSubject?.type, "categories")
      XCTAssertEqual(subs.mainSubject?.id, "182")
      
      let ids = [1013782, 1021335, 978171, 975050, 949093, 944329].map(String.init)
      for (i, bs) in subs.bookshelves.enumerated() {
        XCTAssertEqual(bs.type, "library_items")
        XCTAssertEqual(bs.id, ids[i])
      }
      
      XCTAssertEqual(subs.links.selfLink, "https://api.readmoo.com/read/v2/me/library/subscriptions/58")
      XCTAssertEqual(subs.links.site, "https://readmoo.com/mag/58")
    }
    
    // Test to check is not empty
    do {
      for subs in values {
        XCTAssertNotEqual(subs.type, "")
        XCTAssertNotEqual(subs.id, "")
        XCTAssertNotEqual(subs.name, "")
        XCTAssertNotEqual(subs.period, "")
//        XCTAssertNotEqual(subs.content, "")
        XCTAssertNotEqual(subs.productType.rawValue, "")
        XCTAssertNotEqual(subs.language.rawValue, "")
        XCTAssertNotEqual(subs.publication?.type, "")
        XCTAssertNotEqual(subs.publication?.id, "")
        XCTAssertNotEqual(subs.mainSubject?.type, "")
        XCTAssertNotEqual(subs.mainSubject?.id, "")
        XCTAssertNotEqual(subs.links.selfLink, "")
        XCTAssertNotEqual(subs.links.site, "")
      }
    }
    
    // Test included
    guard let inclusion = result.value?.included else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(inclusion.bookshelfs.count, 98)
    XCTAssertEqual(inclusion.books.count, 98)
  }
  
}
