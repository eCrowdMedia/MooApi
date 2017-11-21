import Foundation

public protocol DownloadEpubOperationDelegate: class {
  func downloadEpubOperation(_ downloadEpubOperation: DownloadEpubOperation, didCompleteWithError error: Error?, with mission: DownloadEpubMission)
  func downloadEpubOperation(_ downloadEpubOperation: DownloadEpubOperation, didFinishDownloadingTo location: URL, with mission: DownloadEpubMission)
  func downloadEpubOperation(_ downloadEpubOperation: DownloadEpubOperation, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64, with mission: DownloadEpubMission)
}

public class DownloadEpubOperation: Operation {

  public let mission: DownloadEpubMission
  
  public var bookURL: URL {
    return mission.bookURL
  }
  
  public var authorization: Authorization {
    return mission.authorization
  }

  public weak var delegate: DownloadEpubOperationDelegate?
  
  fileprivate var session: URLSession?
  fileprivate var downloadTask: URLSessionDownloadTask?
  
  fileprivate var request: URLRequest {
    var request = URLRequest(url: bookURL)
    request.setValue(authorization.header.value, forHTTPHeaderField: authorization.header.field)
    return request
  }
  
  public init(mission: DownloadEpubMission) {
    self.mission = mission
    
    super.init()
  }
  
  override public func main() {
    let configuration = URLSessionConfiguration.background(withIdentifier: bookURL.absoluteString)
    session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    downloadTask = session!.downloadTask(with: request)
    downloadTask!.resume()
  }
  
  override public func cancel() {
    downloadTask?.cancel()
  }
  
}

// MARK: - URLSessionDownloadDelegate
extension DownloadEpubOperation: URLSessionDownloadDelegate {
  
  public func urlSession(
    _ session: URLSession, 
    task: URLSessionTask, 
    didCompleteWithError error: Error?)
  {
    delegate?.downloadEpubOperation(self, didCompleteWithError: error, with: mission)
  }
  
  public func urlSession(
    _ session: URLSession, 
    downloadTask: URLSessionDownloadTask, 
    didFinishDownloadingTo location: URL)
  {
    delegate?.downloadEpubOperation(self, didFinishDownloadingTo: location, with: mission)
  }
  
  public func urlSession(
    _ session: URLSession, 
    downloadTask: URLSessionDownloadTask, 
    didWriteData bytesWritten: Int64, 
    totalBytesWritten: Int64, 
    totalBytesExpectedToWrite: Int64)
  {
    delegate?.downloadEpubOperation(
      self,
      didWriteData: bytesWritten,
      totalBytesWritten: totalBytesWritten,
      totalBytesExpectedToWrite: totalBytesExpectedToWrite,
      with: mission
    )
  }
  
}
