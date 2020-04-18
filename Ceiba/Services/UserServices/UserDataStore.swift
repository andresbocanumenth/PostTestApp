//
//  UserDataStore.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import RealmSwift

class UserDataStore {
    private var realm: Realm!
    private var tokens: [NotificationToken]!
    var refreshData: (() -> Void)?
    
    init() {
        self.realm = try! Realm()
        configureObserver()
    }
    
    func configureObserver() {
        let modelTypes = [UserModel.self] as [RealmSyncable.Type]
        tokens = modelTypes.map { modelType in
            modelType.registerNotificationObserver(for: realm, callback: { [weak self](_) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.refreshData?()
            })
        }
    }
    
    func fetchUsers() -> [UserModel] {        
        return Array(realm.objects(UserModel.self))
    }
    
    func fetchUsers(by userId: Int) -> UserModel? {
        return realm.objects(UserModel.self).first { $0.id == userId }
    }
}
