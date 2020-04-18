//
//  UserListViewModel.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

class UserListViewModel {
    
    private let userDataStore = UserDataStore()

    private var userModels: [UserModel] = []
    var userCellViewModels: [UserCellViewModel] = []
    var refreshData: (() -> Void)?

    init() {
        getData()
        configureBindings()
    }
    
    private func getData() {
        userModels = userDataStore.fetchUsers()
        userCellViewModels = userModels.map {
            UserCellViewModel(model: $0)
        }
    }

    private func configureBindings() {
        userDataStore.refreshData = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.getData()
            strongSelf.refreshData?()
        }
    }
    
    func filterUserBy(_ search: String) {
        if search.isEmpty {
            userCellViewModels = userModels.map {
                UserCellViewModel(model: $0)
            }
        } else {
            userCellViewModels = userModels.filter { $0.name.contains(search) }.map {
                UserCellViewModel(model: $0)
            }
        }
        refreshData?()
    }
}

struct UserCellViewModel {
    
    let userName: String
    let phoneNumber: String
    let mail: String
    let id: Int
        
    init(model: UserModel) {
        userName = model.name + " - @" + model.username
        phoneNumber = model.phone
        mail = model.email
        id = model.id
    }
}
