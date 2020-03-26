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
                   completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void)
}

extension URLSession: NetworkService {
    
    func fetch(from url: URL, completionHandler: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let strongSelf = self else { return }
            let task = strongSelf.dataTask(with: url, completionHandler: { (data, _, error) in
                completionHandler(data, error as NSError?)
            })
            task.resume()
        }
    }
}
