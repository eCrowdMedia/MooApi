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
    
    guard let book = result.value?.data else {
      XCTFail("\(result.error!)")
      return
    }

    // Test all results
    XCTAssertNil(result.error)
    XCTAssertNil(result.value?.meta)
    XCTAssertNil(result.value?.paginationLinks)
    XCTAssertNotNil(result.value?.included)
    
    // Test data
    let attributes = book.attributes
    let relationships = book.relationships
    let links = book.links
    
    XCTAssertEqual(book.type, "books")
    XCTAssertEqual(book.id, "210068285000101")
    XCTAssertEqual(attributes.title, "說服自己，就是最聰明的談判力")
    XCTAssertEqual(attributes.subtitle, "哈佛頂尖談判專家最強效的溝通心理學")
    XCTAssertEqual(attributes.author, "威廉．尤瑞")
    XCTAssertNotNil(attributes.shortDescription)
    XCTAssertNotNil(attributes.largeDescription)
    XCTAssertEqual(attributes.isbn, "9789571365985")
    XCTAssertEqual(attributes.language, "zh-Hant")
    XCTAssertEqual(attributes.mainSubject, "商業理財")
    XCTAssertEqual(attributes.publicationDate, "2016-04-21T16:00:00Z")
    XCTAssertEqual(attributes.isAdultOnly, false)
    XCTAssertEqual(attributes.epub.rendition.layout, "reflowable")
    XCTAssertEqual(attributes.epub.fileSize, 583858) 
    XCTAssertEqual(attributes.epub.latestVersion, "1.000") 
    XCTAssertEqual(attributes.epub.lastModifiedAt, "2017-02-15T07:12:57Z") 
    
    XCTAssertEqual(attributes.isSuspend, false)
    XCTAssertEqual(attributes.isOwn, true)
    
    let prices = [
      ("02", 210, "TWD"),
      ("04", 210, "TWD"),
      ("99", 300, "TWD")
    ]
    for (index, p) in attributes.prices.enumerated() {
      XCTAssertEqual(p.type, prices[index].0)
      XCTAssertEqual(p.amount, prices[index].1)
      XCTAssertEqual(p.currentyCode, prices[index].2)
    }
    
    XCTAssertEqual(attributes.count.unit, "words")
    XCTAssertEqual(attributes.count.amount, 68939)
    
    XCTAssertEqual(links.selfLink, "https://api.readmoo.com/read/v2/books/210068285000101")
    XCTAssertEqual(links.epub, "https://cdn.readmoo.com/book/preview/210068285000101.epub")
    XCTAssertEqual(links.toc, "https://cdn.readmoo.com/book/toc/preview/210068285000101.json")
    XCTAssertEqual(links.reader, "https://readmoo.com/api/Statistics/preview_log/210068285000101")
    XCTAssertEqual(links.site, "https://readmoo.com/book/210068285000101")
    XCTAssertEqual(links.smallImage.href, "https://cdn.readmoo.com/cover/mr/dqjqtph_120x180.jpg?v=0")
    XCTAssertEqual(links.mediumImage.href, "https://cdn.readmoo.com/cover/mr/dqjqtph_210x315.jpg?v=0")
    XCTAssertEqual(links.largeImage.href, "https://cdn.readmoo.com/cover/mr/dqjqtph_460x580.jpg?v=0")
    
    XCTAssertEqual(relationships.publisher.type, "publishers")
    XCTAssertEqual(relationships.publisher.id, "2")
    XCTAssertEqual(relationships.contributors.count, 3)
    XCTAssertEqual(relationships.categories.count, 1)
    
    let cArray = ["24984", "24985", "11793"]
    for (index, c) in relationships.contributors.enumerated() {
      XCTAssertEqual(c.type, "contributors")
      XCTAssertEqual(c.id, cArray[index])
    }

    // Test incluede
    do {
      guard let inclusion = result.value?.included else {
        XCTFail("no included data")
        return
      }
      
      XCTAssertEqual(inclusion.publishers.count, 1)
      XCTAssertEqual(inclusion.contributors.count, 3)
      XCTAssertEqual(inclusion.categories.count, 2)
      
      let p = inclusion.publishers[0]
      XCTAssertEqual(p.type, "publishers")
      XCTAssertEqual(p.id, "2")
      XCTAssertEqual(p.attributes.name, "時報出版")
      XCTAssertEqual(p.links.selfLink, "https://api.readmoo.com/read/v2/publishers/2")
      
      let cArray = [
        ("contributors", "24984", "威廉．尤瑞", "https://api.readmoo.com/read/v2/contributors/24984"),
        ("contributors", "24985", "William Ury", "https://api.readmoo.com/read/v2/contributors/24985"),
        ("contributors", "11793", "沈維君", "https://api.readmoo.com/read/v2/contributors/11793"),
      ]
      
      for (i, c) in inclusion.contributors.enumerated() {
        XCTAssertEqual(c.type, cArray[i].0)
        XCTAssertEqual(c.id, cArray[i].1)
        XCTAssertEqual(c.attributes.name, cArray[i].2)
        XCTAssertEqual(c.links.selfLink, cArray[i].3)
      }
    }
    
  }
  
}
