import Foundation
import enum Argo.DecodeError

public enum ServiceError: Error {
  case network(error: Error)
  case serializeJSON(error: Error)
  case serverError(statusCode: Int, data: Data?)
  case decodedError(error: DecodeError)
  case unknown(error: Error)
}
