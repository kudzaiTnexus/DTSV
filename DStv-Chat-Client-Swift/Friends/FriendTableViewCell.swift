//
//  FriendTableViewCell.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/25.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
        // MARK: - View components
    
    fileprivate let avatar: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        imageView.layer.borderWidth = 2.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    fileprivate let nameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    fileprivate let lastNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .ultraLight)
        label.numberOfLines = 0
        
        return label
    }()
    
     lazy var infoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.3
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    fileprivate let verticalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    fileprivate let horizontalStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()

        // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

    // MARK: - Setup view

extension FriendTableViewCell {
    func setupView() {

        self.verticalStackView.addArrangedSubview(nameLabel)
        self.verticalStackView.addArrangedSubview(lastNameLabel)
        
        self.horizontalStackView.addArrangedSubview(avatar)
        self.horizontalStackView.addArrangedSubview(verticalStackView)
        self.horizontalStackView.addArrangedSubview(infoButton)
        
        self.addSubview(horizontalStackView)
 
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        
    }
    
    func configureView(with friend: Friend) {
        self.nameLabel.text = friend.alias
        self.lastNameLabel.text = friend.lastName
        self.avatar.loadImage(from: friend.imageURL)
    }
    
}
