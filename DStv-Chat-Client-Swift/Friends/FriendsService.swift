//
//  FriendsService.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol FriendsService {
    func fetchFriends(with uuid: String, name: String, completion: @escaping (Friends?, NSError?, Bool) -> ())
}

class FriendsServiceImplementation: FriendsService {
    
    private let serviceURL: String = "http://mobileexam.dstv.com/friends"
    private var service: ServiceClient = ServiceClientImplementation()
    private static let serviceLock = NSLock()
    
    func fetchFriends(with uuid: String, name: String, completion: @escaping (Friends?, NSError?, Bool) -> ()) {
        
        FriendsServiceImplementation.serviceLock.lock()
        
        defer {
            FriendsServiceImplementation.serviceLock.unlock()
        }
        
        let url = serviceURL+";uniqueID="+uuid+";name="+name
        
        service.fetch(from: url, success: { (data) in
            completion(data, nil, true)
        }) { (error) in
            completion(nil, error, false)
        }
    }
    
}
