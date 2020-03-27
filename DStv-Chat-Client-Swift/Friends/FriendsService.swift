//
//  FriendsService.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol FriendsService {
    func fetchFriends(with uuid: String, name: String, completion: @escaping (Friends?, NSError?) -> ())
}

class FriendsServiceImplementation: FriendsService {
    
    private let serviceURL: String = "http://mobileexam.dstv.com/friends"
    private static let serviceLock = NSLock()
    
    func fetchFriends(with uuid: String, name: String, completion: @escaping (Friends?, NSError?) -> ()) {
        
        FriendsServiceImplementation.serviceLock.lock()
        
        defer {
            FriendsServiceImplementation.serviceLock.unlock()
        }
        
        let urlString = serviceURL+";uniqueID="+uuid+";name="+name
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "The URL is nil", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, httpResponse, error) in
            guard error == nil else {
                return completion(nil, error as NSError?)
            }
            guard let responseData = data else {
                return completion(nil, error as NSError?)
            }
            
            guard let _ = data,
                let response = httpResponse as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(nil, error as NSError?)
                    return
            }
            
            do {
                let serviceResponse = try JSONDecoder().decode(Friends.self, from: responseData)
                
                if serviceResponse.result {
                    completion(serviceResponse, nil)
                } else {
                    completion(nil, NSError(domain: serviceResponse.error!, code: 1, userInfo: nil))
                }
            }
            catch {
                completion(nil, NSError(domain: "decoding error", code: 1, userInfo: nil))
            }
            
            
        }
        
        task.resume()
    }
    
}
