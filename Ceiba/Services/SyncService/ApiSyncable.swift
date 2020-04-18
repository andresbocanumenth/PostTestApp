//
//  ApiSyncable.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

public typealias ApiSyncableResponseHandler = (RealmSyncable?, APIServiceError?) -> Void

public protocol ApiSyncable {
    func insert(_ model: RealmSyncable, completion: @escaping ApiSyncableResponseHandler)
    func modify(_ model: RealmSyncable, completion: @escaping ApiSyncableResponseHandler)
}
