//
//  LoginResponse.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let result: Bool
    let error: String?
    let guid, firstName, lastName: String
}
