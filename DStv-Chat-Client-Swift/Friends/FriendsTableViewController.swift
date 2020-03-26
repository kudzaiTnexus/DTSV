//
//  FriendsTableViewController.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    private var param: FriendsRequestParam!
    private let viewModel = FriendsListViewModel()
    
    private var friends: Friends = Friends(result: false, friends: []) {
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
        
        self.viewModel.fetchFriends(with: param) { (friends, error, status) in
            if status {
                self.friends = friends!
            } else {
                print("zvafa")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("logoutTitle", comment: ""), style: .done, target: self, action: #selector(onLogoutButtonTap))
        
        
        self.tableView.separatorStyle = .none
        self.title = NSLocalizedString("friendsTitle", comment: "")
        self.registerTableViewCells()
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
}
