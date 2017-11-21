import Foundation

public protocol DownloadEpubObserver: class {
  func downloadQueue(_ downloadQueue: OperationQueue, didCompleteWithError error: Error?, withMission mission: DownloadEpubMission)
  func downloadQueue(_ downloadQueue: OperationQueue, didFinishDownloadingTo location: URL, withMission mission: DownloadEpubMission)
  func downloadQueue(_ downloadQueue: OperationQueue, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64, withMission mission: DownloadEpubMission)
}
