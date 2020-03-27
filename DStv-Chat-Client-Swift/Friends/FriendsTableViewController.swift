//
//  FriendsTableViewController.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

//MARK: Retry
protocol RetryDelegate: class {
    func onRetryTap()
}

class FriendsTableViewController: MainTableViewController {
    
    private var param: FriendsRequestParam!
    private let viewModel = FriendsListViewModel()
    private lazy var errorViewController = ErrorViewController()
    
    private var friends: Friends = Friends(error: nil, result: false, friends: []) {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(with param: FriendsRequestParam) {
        super.init(nibName: nil, bundle: nil)
        
        self.param = param
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerTableViewCells() {
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "\(FriendTableViewCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("logoutTitle", comment: ""), style: .done, target: self, action: #selector(onLogoutButtonTap))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("showError", comment: ""), style: .done, target: self, action: #selector(onShowErrorTap(sender:)))
        
        self.tableView.separatorStyle = .none
        self.title = NSLocalizedString("friendsTitle", comment: "")
        self.registerTableViewCells()
        
        self.errorViewController.delegate = self
    }
    
    func fetchData() {
        self.showActivityIndicator()
        
        self.viewModel.fetchFriends(with: param) { (friends, error) in
            
            guard let friendsList = friends else {
                self.showErrorView()
                return
            }
            
            if friendsList.result {
                self.hideActivityIndicator()
                self.friends = friends!
            } else {
                self.hideActivityIndicator()
                self.showErrorView()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "\(FriendTableViewCell.self)", for: indexPath) as! FriendTableViewCell
        
        
        friendCell.configureView(with: friends.friends[indexPath.row])
        friendCell.infoButton.addTarget(self, action: #selector(onTapInfoButton), for: .touchUpInside)
        
        return friendCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewContoller = DetailsViewController(with: friends.friends[indexPath.row])
        detailsViewContoller.modalPresentationStyle = .custom
        self.present(detailsViewContoller, animated: true, completion: nil)
    }
    
    @objc func onTapInfoButton(sender: UIButton) {
        
        guard let cell = sender.superview?.superview as? FriendTableViewCell else {
            return
        }
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let detailsViewContoller = DetailsViewController(with: friends.friends[indexPath.row])
        detailsViewContoller.modalPresentationStyle = .custom
        self.present(detailsViewContoller, animated: true, completion: nil)
    }
    
    @objc func onLogoutButtonTap(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onShowErrorTap(sender: UIBarButtonItem) {
        self.showErrorView()
    }
}

extension FriendsTableViewController: RetryDelegate {
    
    func onRetryTap() {
        self.hideErrorView()
        self.fetchData()
    }
    
    func showErrorView() {
        self.addChild(errorViewController)
        self.errorViewController.view.frame = view.bounds
        self.view.addSubview(errorViewController.view)
        self.view.bringSubviewToFront(errorViewController.view)
        self.errorViewController.didMove(toParent: self)
    }
    
    func hideErrorView() {
        self.errorViewController.willMove(toParent: nil)
        self.errorViewController.view.removeFromSuperview()
        self.errorViewController.removeFromParent()
    }
}
