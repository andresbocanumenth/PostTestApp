//
//  Environment.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

public typealias ResponseJSON = [String : Any]

enum Endpoint: String {
    case fetchUser = "/users"
    case fetchPostByUser = "/posts?userId=%d"
}

extension Endpoint {
    var url : String {
        return Current.baseURL.appending(self.rawValue)
    }
}

public struct Environment {
    public var syncService: SyncService
    public var baseURL: String

    public init(syncService: SyncService,
                baseURL: String) {
        self.syncService = syncService
        self.baseURL = baseURL
    }
}

extension Environment {
    public static let realm = Environment(syncService: SyncService(),
                                          baseURL: "https://jsonplaceholder.typicode.com")
}

public enum APIServiceError: Error {
    case apiError
    case invalidResponse
}

public var Current: Environment = .realm

