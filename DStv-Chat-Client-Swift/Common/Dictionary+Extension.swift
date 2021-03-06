//
//  Dictionary+Extension.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

extension Dictionary {
    var jsonObject: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        }
        catch {
            return nil
        }
    }
}


