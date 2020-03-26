//
//  LoginService.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol LoginService {
    func login(with user: User, completion:@escaping (_ responseObject:LoginResponse?, _ error:NSError?, _ success:Bool)->())
}

struct LoginServiceImplementation: LoginService {
    
    private let serviceURL: String = "http://mobileexam.dstv.com/login"
    private var service: ServiceClient = ServiceClientImplementation()
    private static let serviceLock = NSLock()
    
    func login(with user: User, completion: @escaping (LoginResponse?, NSError?, Bool) -> ()) {
        
        LoginServiceImplementation.serviceLock.lock()
        
        defer {
            LoginServiceImplementation.serviceLock.unlock()
        }

        guard let requestDict = user.dictionary,
            let requestData = requestDict.jsonObject else {
                return
        }
        
        service.post(from: serviceURL, requestParam: requestData, success: { (data) in
            
            completion(data, nil, true)
        }) { (error) in
            completion(nil, error, false)
        }
    }

}
