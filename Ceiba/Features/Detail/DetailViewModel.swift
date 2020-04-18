//
//  DetailViewModel.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

class DetailViewModel {
    
    var refreshData: (() -> Void)?
    var didGetUserInfo: ((UserModel?) -> Void)?
    var postModels: [PostModel] = []
    private let postDataStore = PostDataStore()
    private let userDataStore = UserDataStore()
    private var userId: Int = 0
    
    init() {
        postDataStore.refreshData = {
            self.updateData()
        }
    }
    
    func fetchData(by userId: Int) {
        didGetUserInfo?(userDataStore.fetchUsers(by: userId))
        self.userId = userId
        updateData()
    }
    
    private func updateData() {
        postModels = postDataStore.fetchData(by: userId)
        refreshData?()
    }
}
