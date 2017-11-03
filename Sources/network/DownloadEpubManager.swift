import Foundation

public class DownloadEpubManager {
  
  // MARK: Public properties
  
  public static let shared = DownloadEpubManager()
  
  // MARK: Initialization
  
  public init() {
    downloadQueue = {
      let queue = OperationQueue()
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
  }
  
  // MARK: Private properties
  
  fileprivate var observers = [DownloadEpubObserver]()
  fileprivate let downloadQueue: OperationQueue
  
}

// MARK: - Public methods
extension DownloadEpubManager {
  
  public func add<O: DownloadEpubObserver>(observer: O) {
    observers.append(observer)
  }
  
  public func remove<O: DownloadEpubObserver>(observer: O) {
    guard let index = observers.index(where: { $0 === observer }) else { return }
    
    observers.remove(at: index)
  }
  
  public func start(mission: DownloadEpubMission) {
    let downloadOperation = DownloadEpubOperation(mission: mission)
    downloadOperation.delegate = self
    downloadQueue.addOperation(downloadOperation)
  }
  
  public func cancel(mission: DownloadEpubMission) {
    downloadQueue.operations
      .flatMapAsDownloadOperation()
      .filter { $0.mission == mission }
      .forEach { $0.cancel() }
  }
  
  public func cancelAllMissions() {
    downloadQueue.cancelAllOperations()
  }
  
}

// MARK: - DownloadEpubOperationDelegate
extension DownloadEpubManager: DownloadEpubOperationDelegate {
  
  public func downloadEpubOperation(
    _ downloadEpubOperation: DownloadEpubOperation,
    didCompleteWithError error: Error?,
    with mission: DownloadEpubMission)
  {
    for o in observers {
      o.downloadQueue(downloadQueue, didCompleteWithError: error, withMission: mission)
    }
  }
  
  public func downloadEpubOperation(
    _ downloadEpubOperation: DownloadEpubOperation,
    didFinishDownloadingTo location: URL,
    with mission: DownloadEpubMission)
  {
    for o in observers {
      o.downloadQueue(downloadQueue, didFinishDownloadingTo: location, withMission: mission)
    }
  }
  
  public func downloadEpubOperation(
    _ downloadEpubOperation: DownloadEpubOperation,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64,
    with mission: DownloadEpubMission)
  {
    for o in observers {
      o.downloadQueue(
        downloadQueue,
        didWriteData: bytesWritten,
        totalBytesWritten: totalBytesWritten, 
        totalBytesExpectedToWrite: totalBytesExpectedToWrite, 
        withMission: mission
      )
    }
  }
  
}

// MARK: - Array extension
extension Array where Element: Operation {
  
  fileprivate func flatMapAsDownloadOperation() -> [DownloadEpubOperation] {
    return flatMap { $0 as? DownloadEpubOperation }
  }
  
}
