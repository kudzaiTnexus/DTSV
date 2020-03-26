//
//  Friend.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

struct Friends: Codable {
    let result: Bool
    let friends: [Friend]
}

struct Friend: Codable {
    let firstName, lastName, alias, dateOfBirth: String
    let imageURL: String
    let status: String
}

