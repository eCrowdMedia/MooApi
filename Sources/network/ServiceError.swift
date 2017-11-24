import Foundation
import enum Argo.DecodeError

public enum ServiceError: Error {
  case network(error: Error)
  case serializeJSONFailed
  case serverFailedToReach(statusCode: Int, reason: ApiDocumentErrorEnvelope?)
  case apiExecitionFailed(statusCode: Int, reason: ApiDocumentErrorEnvelope?)
  case decodedError(DecodeError)
  case nativeDecodedError(error: Error)
  case dataNotExisted
  case invalidApi(statusCode: Int, reason: ApiDocumentErrorEnvelope?)
}
