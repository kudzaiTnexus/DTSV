//
//  NetworkSession.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

protocol NetworkService {
    func fetch(from url: URL,
               completionHandler: @escaping (_ data: Friends?, _ error: NSError?) -> Void)
    func post(to url: URL,
              userInfo: Data, completion: @escaping (_ data: LoginResponse?, _ error: NSError?) -> Void)
}

extension URLSession: NetworkService {
    
    func post(to url: URL, userInfo: Data, completion: @escaping (LoginResponse?, NSError?) -> Void) {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = userInfo
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
    
    func fetch(from url: URL, completionHandler: @escaping (_ data: Friends?, _ error: NSError?) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let strongSelf = self else { return }
            
            let task = strongSelf.dataTask(with: url, completionHandler: { (data, httpResponse, error) in
                
                guard error == nil else {
                    return completionHandler(nil, error as NSError?)
                }
                guard let responseData = data else {
                    return completionHandler(nil, error as NSError?)
                }
                
                guard let _ = data,
                    let response = httpResponse as? HTTPURLResponse,
                    (200 ..< 300) ~= response.statusCode,
                    error == nil else {
                        completionHandler(nil, error as NSError?)
                        return
                }
                
                do {
                    let serviceResponse = try JSONDecoder().decode(Friends.self, from: responseData)
                    
                    if serviceResponse.result {
                        completionHandler(serviceResponse, nil)
                    } else {
                        completionHandler(nil, NSError(domain: "error occured", code: 1, userInfo: nil))
                    }
                }
                catch {
                    completionHandler(nil, NSError(domain: "decoding error", code: 3, userInfo: nil))
                }
            })
            task.resume()
        }
    }
}
