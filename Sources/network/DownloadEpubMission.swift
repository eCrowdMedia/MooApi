import Foundation

public struct DownloadEpubMission {
  public let bookId: String
  public let bookURL: URL
  public let authorization: Authorization
}

extension DownloadEpubMission: Equatable {
  
  public static func ==(lhs: DownloadEpubMission, rhs: DownloadEpubMission) -> Bool {
    return lhs.bookId == rhs.bookId && lhs.bookURL == rhs.bookURL && lhs.authorization == rhs.authorization
  }

}
