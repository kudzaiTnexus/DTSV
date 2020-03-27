//
//  LoginService.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol LoginService {
    func login(with user: User, completion:@escaping (_ responseObject:LoginResponse?, _ error:NSError?)->())
}

struct LoginServiceImplementation: LoginService {
    
    private let serviceURL: String = "http://mobileexam.dstv.com/login"
    private static let serviceLock = NSLock()
    
    func login(with user: User, completion: @escaping (LoginResponse?, NSError?) -> ()) {
        
        LoginServiceImplementation.serviceLock.lock()
        
        defer {
            LoginServiceImplementation.serviceLock.unlock()
        }

        guard let requestDict = user.dictionary,
            let requestData = requestDict.jsonObject else {
                return
        }
        
        guard let url = URL(string: serviceURL) else {
            completion(nil, NSError(domain: "The URL is nil", code: 0, userInfo: nil))
            return
        }
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = requestData
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
                let serviceResponse = try JSONDecoder().decode(LoginResponse.self, from: responseData)
                
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
