//
//  FriendsListViewModel.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

class FriendsListViewModel {
    
    private var friendsService: FriendsService = FriendsServiceImplementation()
    
    func fetchFriends(with param: FriendsRequestParam, completion: @escaping (Friends?, NSError?) -> ()) {
        friendsService.fetchFriends(with: param.uniqueID, name: param.name) { (friends, error) in
            DispatchQueue.main.async {
                completion(friends, nil)
            }
        }
    }
}
