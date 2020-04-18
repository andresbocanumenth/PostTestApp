//
//  PostService.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias PostResponseHandler = ([PostModel]?, APIServiceError?) -> Void

class PostService {
    static func fetchPostBy(userId: Int, completion: @escaping PostResponseHandler) {
        let endpoint = String(format: Endpoint.fetchPostByUser.url, userId)
        AF.request(endpoint).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    guard let json = value as? [ResponseJSON] else {
                        completion(nil, .invalidResponse)
                        return
                    }
                    let models = Mapper<PostModel>().mapArray(JSONArray: json)
                    completion(models, nil)
                    break;
                case .failure(_):
                    completion(nil, .apiError)
                    break
            }
        }
    }
}
