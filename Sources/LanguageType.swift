import Argo

public enum LanguageType: String {
  case zhHant = "zh-Hant"
  case zhHans = "zh-Hans"
  case en     = "en"
  case ja     = "ja"
  case fr     = "fr"
}

extension LanguageType: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<LanguageType> {
    switch json {
    case let .string(language):
      if let languageType = LanguageType(rawValue: language) {
        return .success(languageType)
      } else {
        return .failure(.typeMismatch(expected: "LanguageType", actual: language))
      }
    default:
      return .failure(.typeMismatch(expected: "String", actual: json.description))
    }
  }
}
