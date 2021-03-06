//
//  MainViewController.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MainViewController {
    
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

extension MainViewController {
    func showErrorAlert(with title: String, message: String) {
        let offlineAlert = UIAlertController(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        offlineAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(offlineAlert, animated: true, completion: nil)
    }
}
