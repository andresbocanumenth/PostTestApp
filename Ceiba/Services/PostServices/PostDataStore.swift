//
//  PostDataStore.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import RealmSwift

class PostDataStore {
    
    private var realm: Realm!
    private var tokens: [NotificationToken]!
    var refreshData: (() -> Void)?
    
    init() {
        self.realm = try! Realm()
        configureObserver()
    }
    
    func configureObserver() {
        let modelTypes = [PostModel.self] as [RealmSyncable.Type]
        tokens = modelTypes.map { modelType in
            modelType.registerNotificationObserver(for: realm, callback: { [weak self](_) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.refreshData?()
            })
        }
    }
    
    func fetchData(by userId: Int) -> [PostModel] {
        let result = Array(realm.objects(PostModel.self)).filter { $0.userId == userId }
        PostService.fetchPostBy(userId: userId, completion: Current.syncService.syncModels(models:error:))
        return result
    }
}
