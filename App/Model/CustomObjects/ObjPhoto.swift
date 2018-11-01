//
//  ObjPhoto.swift
//
//  Created by Javed Multani on 25/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ObjPhoto: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let isfriend = "isfriend"
    static let farm = "farm"
    static let id = "id"
    static let server = "server"
    static let secret = "secret"
    static let owner = "owner"
    static let title = "title"
    static let ispublic = "ispublic"
    static let isfamily = "isfamily"
  }

  // MARK: Properties
  public var isfriend: Int?
  public var farm: Int?
  public var id: String?
  public var server: String?
  public var secret: String?
  public var owner: String?
  public var title: String?
  public var ispublic: Int?
  public var isfamily: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    isfriend = json[SerializationKeys.isfriend].int
    farm = json[SerializationKeys.farm].int
    id = json[SerializationKeys.id].string
    server = json[SerializationKeys.server].string
    secret = json[SerializationKeys.secret].string
    owner = json[SerializationKeys.owner].string
    title = json[SerializationKeys.title].string
    ispublic = json[SerializationKeys.ispublic].int
    isfamily = json[SerializationKeys.isfamily].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isfriend { dictionary[SerializationKeys.isfriend] = value }
    if let value = farm { dictionary[SerializationKeys.farm] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = server { dictionary[SerializationKeys.server] = value }
    if let value = secret { dictionary[SerializationKeys.secret] = value }
    if let value = owner { dictionary[SerializationKeys.owner] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = ispublic { dictionary[SerializationKeys.ispublic] = value }
    if let value = isfamily { dictionary[SerializationKeys.isfamily] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isfriend = aDecoder.decodeObject(forKey: SerializationKeys.isfriend) as? Int
    self.farm = aDecoder.decodeObject(forKey: SerializationKeys.farm) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.server = aDecoder.decodeObject(forKey: SerializationKeys.server) as? String
    self.secret = aDecoder.decodeObject(forKey: SerializationKeys.secret) as? String
    self.owner = aDecoder.decodeObject(forKey: SerializationKeys.owner) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.ispublic = aDecoder.decodeObject(forKey: SerializationKeys.ispublic) as? Int
    self.isfamily = aDecoder.decodeObject(forKey: SerializationKeys.isfamily) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isfriend, forKey: SerializationKeys.isfriend)
    aCoder.encode(farm, forKey: SerializationKeys.farm)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(server, forKey: SerializationKeys.server)
    aCoder.encode(secret, forKey: SerializationKeys.secret)
    aCoder.encode(owner, forKey: SerializationKeys.owner)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(ispublic, forKey: SerializationKeys.ispublic)
    aCoder.encode(isfamily, forKey: SerializationKeys.isfamily)
  }

}
