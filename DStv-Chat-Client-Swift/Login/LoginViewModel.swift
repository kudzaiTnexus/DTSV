//
//  LoginViewModel.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    private var loginService: LoginService = LoginServiceImplementation()
    
    func signIn(username: String, password: String, completion: @escaping (LoginResponse?, NSError?, Bool) -> ()) {
        
        let requestParams: User = User(username: username, password: password)
        
        loginService.login(with: requestParams) { (data, error, bool) in
            DispatchQueue.main.async {
                completion(data, error, bool)
            }
        }
    }
    
}
