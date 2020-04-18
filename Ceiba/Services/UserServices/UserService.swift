//
//  UserService.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias UsersResponseHandler = ([UserModel]?, APIServiceError?) -> Void

class UserService {
    
    static func fetchUsers(completion: @escaping UsersResponseHandler) {
        AF.request(Endpoint.fetchUser.url).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    guard let json = value as? [ResponseJSON] else {
                        completion(nil, .invalidResponse)
                        return
                    }
                    let models = Mapper<UserModel>().mapArray(JSONArray: json)
                    completion(models, nil)
                    break;
                case .failure(_):
                    completion(nil, .apiError)
                    break
            }
        }
    }
}
