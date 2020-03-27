//
//  UITableView+Extension.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/27.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewController: UITableViewController {

    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MainTableViewController {
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
}
