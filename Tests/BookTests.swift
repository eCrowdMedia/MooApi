// import XCTest
// @testable import MooApi
// import Argo

// final internal class BookTests: XCTestCase {

//   func testBookModel() {
    
//     let testBundle = Bundle(for: type(of: self))
//     let path = testBundle.path(forResource: "BookInfo", ofType: "json")
//     let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
//     let json = JSON(try! JSONSerialization.jsonObject(with: data, options: []))
//     let result = ApiDocument<Book>.decode(json)
//     let book = result.value?.data
    
//     // Test all results
//     XCTAssertNil(result.error)
//     XCTAssertNil(result.value?.meta)
//     XCTAssertNil(result.value?.paginationLinks)
//     XCTAssertNotNil(result.value?.included)
    
//     // Test data
//     XCTAssertNotNil(book)
//     XCTAssertEqual(book?.type, "books")
//     XCTAssertEqual(book?.id, "210068285000101")
//     XCTAssertEqual(book?.title.normal, "說服自己，就是最聰明的談判力")
//     XCTAssertEqual(book?.title.subtitle, "哈佛頂尖談判專家最強效的溝通心理學")
//     XCTAssertEqual(book?.author, "威廉．尤瑞")
//     XCTAssertNotNil(book?.descriptionInfo.short)
//     XCTAssertNotNil(book?.descriptionInfo.large)
//     XCTAssertEqual(book?.isbn, "9789571365985")
//     XCTAssertEqual(book?.language.rawValue, "zh-Hant")
//     XCTAssertEqual(book?.publicationDate, "2016-04-21T16:00:00Z")
//     XCTAssertEqual(book?.isAdultOnly, false)
//     XCTAssertEqual(book?.fileSize, 583858)
//     XCTAssertEqual(book?.rendition.layout, "reflowable")
//     XCTAssertEqual(book?.isSuspend, false)
//     XCTAssertEqual(book?.isOwn, true)
    
//     let prices = [
//       ("02", 210, "TWD"),
//       ("04", 210, "TWD"),
//       ("99", 300, "TWD")
//     ]
//     for (index, p) in book!.prices.enumerated() {
//       XCTAssertEqual(p.type, prices[index].0)
//       XCTAssertEqual(p.amount, prices[index].1)
//       XCTAssertEqual(p.currentyCode, prices[index].2)
//     }
    
//     XCTAssertEqual(book?.count.unit, "words")
//     XCTAssertEqual(book?.count.amount, 68939)
    
//     XCTAssertEqual(book?.links.selfLink, "https://api.readmoo.com/read/v2/books/210068285000101")
//     XCTAssertEqual(book?.links.site, "https://readmoo.com/book/210068285000101")
//     XCTAssertEqual(book?.links.smallImage, "https://cdn.readmoo.com/cover/mr/dqjqtph_120x180.jpg?v=0")
//     XCTAssertEqual(book?.links.mediumImage, "https://cdn.readmoo.com/cover/mr/dqjqtph_210x315.jpg?v=0")
//     XCTAssertEqual(book?.links.largeImage, "https://cdn.readmoo.com/cover/mr/dqjqtph_460x580.jpg?v=0")
    
//     XCTAssertEqual(book?.publisher?.type, "publishers")
//     XCTAssertEqual(book?.publisher?.id, "2")
//     XCTAssertEqual(book?.mainSubject?.type, "categories")
//     XCTAssertEqual(book?.mainSubject?.id, "136")
//     XCTAssertEqual(book?.contributors.count, 3)
    
//     let cArray = ["24984", "24985", "11793"]
//     for (index, c) in book!.contributors.enumerated() {
//       XCTAssertEqual(c.type, "contributors")
//       XCTAssertEqual(c.id, cArray[index])
//     }

//     // Test incluede
//     do {
//       guard let inclusion = result.value?.included else {
//         XCTFail("no included data")
//         return
//       }
      
//       XCTAssertEqual(inclusion.publishers.count, 1)
//       XCTAssertEqual(inclusion.contributors.count, 3)
//       XCTAssertEqual(inclusion.categories.count, 1)
      
//       let p = inclusion.publishers[0]
//       XCTAssertEqual(p.type, "publishers")
//       XCTAssertEqual(p.id, "2")
//       XCTAssertEqual(p.name, "時報出版")
//       XCTAssertEqual(p.link, "https://api.readmoo.com/read/v2/publishers/2")
      
//       let cArray = [
//         ("contributors", "24984", "威廉．尤瑞", "https://api.readmoo.com/read/v2/contributors/24984"),
//         ("contributors", "24985", "William Ury", "https://api.readmoo.com/read/v2/contributors/24985"),
//         ("contributors", "11793", "沈維君", "https://api.readmoo.com/read/v2/contributors/11793"),
//       ]
      
//       for (i, c) in inclusion.contributors.enumerated() {
//         XCTAssertEqual(c.type, cArray[i].0)
//         XCTAssertEqual(c.id, cArray[i].1)
//         XCTAssertEqual(c.name, cArray[i].2)
//         XCTAssertEqual(c.link, cArray[i].3)
//       }
//     }
    
//   }
  
// }
