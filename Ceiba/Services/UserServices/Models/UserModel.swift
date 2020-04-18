//
//  UserModel.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class UserModel: Object, Syncable, Mappable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        phone <- map["phone"]
    }
    
    func sync(completion: @escaping RealmSyncableResponseHandler) {
        
    }
    
    static func fetchData(completion: @escaping SyncableFetchDataResponseHandler) {
        UserService.fetchUsers(completion: completion)
    }
}

