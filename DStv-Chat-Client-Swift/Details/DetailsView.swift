//
//  DetailsView.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/26.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    // MARK: - View Components
    
    private let nameView: UserDataView = {
        let detailsView = UserDataView(frame: .zero)
        return detailsView
    }()
    
    private let lastNameView: UserDataView = {
        let detailsView = UserDataView(frame: .zero)
        return detailsView
    }()
    
    private let aliasView: UserDataView = {
        let detailsView = UserDataView(frame: .zero)
        return detailsView
    }()
    
    private let dateOfBirthView: UserDataView = {
        let detailsView = UserDataView(frame: .zero)
        return detailsView
    }()
    
    private let verticalstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
        
    private let friendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let statusView: MemberOnlineView = {
        let view = MemberOnlineView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -25
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = -20
        stackView.alignment = .leading
        
        return stackView
    }()
    
        // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        friendImage.heightAnchor.constraint(equalToConstant: self.frame.size.height/1.5).isActive = true
        
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveLinear, animations: {
            self.stackView.alpha = 1.0
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    // MARK: - Setup Views

extension DetailsView {
    
    func setupView() {
        
        statusStackView.addArrangedSubview(friendImage)
        statusStackView.addArrangedSubview(statusView)
        
        verticalstackView.addArrangedSubview(aliasView)
        verticalstackView.addArrangedSubview(nameView)
        verticalstackView.addArrangedSubview(lastNameView)
        verticalstackView.addArrangedSubview(dateOfBirthView)
        
        stackView.addArrangedSubview(statusStackView)
        stackView.addArrangedSubview(verticalstackView)
        stackView.alpha = 0
        
        addSubview(stackView)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        friendImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        aliasView.translatesAutoresizingMaskIntoConstraints = false
        aliasView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        lastNameView.translatesAutoresizingMaskIntoConstraints = false
        lastNameView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        dateOfBirthView.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func configureView(with friend: Friend) {
        friendImage.loadImage(from: friend.imageURL)
        self.aliasView.configureView(with: "Alias", subTitle: friend.alias)
        self.nameView.configureView(with: "Name", subTitle: friend.firstName)
        self.lastNameView.configureView(with: "Lastname", subTitle: friend.lastName)
        self.dateOfBirthView.configureView(with: "D.O.B", subTitle: friend.dateOfBirth)
        
        self.statusView.configureView(with: friend.status)
    }
}
