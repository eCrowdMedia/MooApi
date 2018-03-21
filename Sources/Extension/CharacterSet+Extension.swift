import Foundation

extension CharacterSet {
  
  static var rfc3986Unreserved: CharacterSet {
    var characterSet = CharacterSet.alphanumerics
    characterSet.insert(charactersIn: "-_:~")
    return characterSet
  }
  
}
