//
//  MemberOnlineStatus.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/26.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

enum MemberOnlineStatus: String {
    case online = "Online"
    case busy = "Busy"
    case away = "Away"
    case offline = "Offline"
}

class MemberOnlineView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var backgroundView: UIView = {
        let bdView = UIView(frame: .zero)
         bdView.translatesAutoresizingMaskIntoConstraints = false
        return bdView
    }()
    
    let onlineLabel: UILabel = {

        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    var status: MemberOnlineStatus = MemberOnlineStatus.away {
        didSet {
            switch status {
            case MemberOnlineStatus.away:
                backgroundView.backgroundColor = UIColor.gray
            case MemberOnlineStatus.online:
                backgroundView.backgroundColor = UIColor.green
            case MemberOnlineStatus.busy:
                backgroundView.backgroundColor = UIColor.purple
            case .offline:
                backgroundView.backgroundColor = UIColor.orange
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        stackView.addArrangedSubview(backgroundView)
        stackView.addArrangedSubview(onlineLabel)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 10,
                                               bottom: 0,
                                               right: 0)
        
        addSubview(stackView)
        
        backgroundView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        backgroundView.layer.cornerRadius = 8
    }
    
    func configureView(with status: String) {
        onlineLabel.text = status
        
        guard let status = MemberOnlineStatus(rawValue: status) else { return }
        
        self.status = status
    }
    
}
