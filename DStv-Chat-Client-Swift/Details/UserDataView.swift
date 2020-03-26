//
//  UserDataView.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/26.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import UIKit

class UserDataView: UIView {
    
        // MARK: - View components
    
    private let titleLabel: UILabel = {

        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0

        return label
    }()
    
    private let subTitleLabel: UILabel = {

        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14, weight: .ultraLight)
        label.numberOfLines = 0

        return label
    }()
    
    private let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
        // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

    // MARK: - Setup view

extension UserDataView {

    func setupView() {
        
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 10,
                                               bottom: 0,
                                               right: 0)

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }

    func configureView(with title: String, subTitle: String) {

        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
