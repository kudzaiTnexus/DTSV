//
//  ServiceClient.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol ServiceClient: class {
    func fetch(from urlString: String,
               success: @escaping (_ responseData: Friends) -> (),
               failure: @escaping (_ error: NSError?) -> ())
    
    func post(from urlString: String,
              requestParam: Data,
              success: @escaping (_ responseData: LoginResponse?) -> (),
              failure: @escaping (_ error: NSError?) -> ())
}

class ServiceClientImplementation: ServiceClient {
    
    private let session: NetworkService
    
    init(session: NetworkService = URLSession.shared) {
        self.session = session
    }
    
    func fetch(from urlString: String,
               success: @escaping (_ responseData: Friends) -> (),
               failure: @escaping (_ error: NSError?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            return failure(NSError(domain: "The URL is nil", code: 0, userInfo: nil))
        }
        
        session.fetch(from: url) { (data, error) in
            guard error == nil, let responseData = data else {
                return failure(error)
            }
            success(responseData)
        }
    }
    
    func post(from urlString: String,
              requestParam: Data, success: @escaping (LoginResponse?) -> (), failure: @escaping (NSError?) -> ()) {
        guard let url = URL(string: urlString) else {
            return failure(NSError(domain: "The URL is nil", code: 0, userInfo: nil))
        }
        
        session.post(to: url, userInfo: requestParam) { (data, error) in
            guard error == nil, let responseData = data else {
                return failure(error)
            }
            success(responseData)
        }
    }
}
