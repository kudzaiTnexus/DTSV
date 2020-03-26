//
//  UITextField+Extension.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10,
                                                 y: 5,
                                                 width: 20,
                                                 height: 20))
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20,
                                                             y: 0,
                                                             width: 35,
                                                             height: 30))
        
        iconView.image = image
        
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
