import Argo
import Curry
import Runes

public struct Bookshelf: ResourceType {

  public let type: String
  public let id: String
  public let attributes: Attributes
  public let relationships: Relationships
  public let links: Links

  public struct Attributes {
    public let isNew: Bool
    public let privacy: String
    public let isArchive: Bool
    public let isSubscribable: Bool // if true is magazation, else is book.
    public let policy: Policy?
    
    public struct Policy {
      public let type: String
      public let permissions: [Permission]
      public let prohibitions: [Prohibition]
    }
    
    public struct Permission {
      public let action: String
      public let constraints: [Constraint]
    }
    
    public struct Prohibition {
      public let action: String
      public let constraints: [Constraint]
    }
    
    public struct Constraint {
      public let name: String?
      public let constraintOperator: String
      public let rightOperand: String?
    }
  }

  public struct Relationships {
    public let reading: ResourceIdentifier
  }

  public struct Links {
    public let selfLink: String
    public let reader: String
    public let epub: String
    public let toc: String
  }

}

extension Bookshelf: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf> {
    return curry(Bookshelf.init)
      <^> json <| "type"
      <*> json <| "id"
      <*> json <| "attributes"
      <*> json <| "relationships"
      <*> json <| "links"
  }
}

extension Bookshelf.Attributes: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes> {
    return curry(Bookshelf.Attributes.init)
      <^> json <| "new"
      <*> json <| "privacy"
      <*> json <| "archive"
      <*> json <| "subscribable"
      <*> json <|? "policy"
  }
}

extension Bookshelf.Attributes.Policy: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes.Policy> {
    return curry(Bookshelf.Attributes.Policy.init)
      <^> json <| "type"
      <*> json <|| "permissions"
      <*> json <|| "prohibitions"
  }
}

extension Bookshelf.Attributes.Permission: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes.Permission> {
    return curry(Bookshelf.Attributes.Permission.init)
      <^> json <| "action"
      <*> json <|| "constraints"
  }
}

extension Bookshelf.Attributes.Prohibition: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes.Prohibition> {
    return curry(Bookshelf.Attributes.Prohibition.init)
      <^> json <| "action"
      <*> json <|| "constraints"
  }
}

extension Bookshelf.Attributes.Constraint: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Attributes.Constraint> {
    return curry(Bookshelf.Attributes.Constraint.init)
      <^> json <|? "name"
      <*> json <| "operator"
      <*> json <|? "rightoperand"
  }
}

extension Bookshelf.Relationships: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Relationships> {
    return curry(Bookshelf.Relationships.init)
      <^> json <| "reading"
  }
}

extension Bookshelf.Links: Argo.Decodable {
  public static func decode(_ json: JSON) -> Decoded<Bookshelf.Links> {
    return curry(Bookshelf.Links.init)
      <^> json <| "self"
      <*> json <| "reader"
      <*> json <| "epub"
      <*> json <| "toc"
  }
}
