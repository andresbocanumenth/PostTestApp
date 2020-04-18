//
//  PostModel.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class PostModel: Object, Syncable, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
    
    func sync(completion: @escaping RealmSyncableResponseHandler) {
        
    }
    
    static func fetchData(completion: @escaping SyncableFetchDataResponseHandler) {
        
    }
}

