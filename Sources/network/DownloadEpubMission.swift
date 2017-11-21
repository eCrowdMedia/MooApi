import Foundation

public struct DownloadEpubMission {
  public let bookId: String
  public let bookURL: URL
  public let authorization: Authorization
  //TODO: 為了續傳準備 now byte ＆ tatal byte ＆ checksum 需要紀錄
  
  public init(bookId: String, bookURL: URL, authorization: Authorization) {
    self.bookId = bookId
    self.bookURL = bookURL
    self.authorization = authorization
  }
}

extension DownloadEpubMission: Equatable {
  
  public static func ==(lhs: DownloadEpubMission, rhs: DownloadEpubMission) -> Bool {
    return lhs.bookId == rhs.bookId && lhs.bookURL == rhs.bookURL && lhs.authorization == rhs.authorization
  }

}
