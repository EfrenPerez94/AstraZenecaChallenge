//
//  ContactsTableViewCell.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Contact Table View Cell. Handle contact information as cell.
final class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    var contact: Contact? {
        didSet {
            self.latestPostLabel.text = ""
            self.usernameLabel.text = contact?.userName
            if contact?.post?.count ?? 0 > 0 {
                self.latestPostLabel.text = contact?.post?[0].content
            }
        }
    }
    
    /// Closure to handle button action
    var buttonDetailTap: (() -> Void)?
    
    lazy var contactImageView: UIImageView = {
        let contactImageView = UIImageView()
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.borderWidth = 3
        contactImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contactImageView.layer.cornerRadius = 55
        contactImageView.layer.masksToBounds = true
        return contactImageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes UI elements
    private func setup() {
        addSubview(contactImageView)
        addSubview(usernameLabel)
        addSubview(latestPostLabel)
        addSubview(detailButton)
        // Actions
        detailButton.addTarget(self, action: #selector(detailTouchUpInside(_:)), for: .touchUpInside)
    }
    
    // MARK: WelcomeView delegates
    @objc func detailTouchUpInside(_ sender: UIButton) {
        buttonDetailTap?()
    }
    
    private var isViewConstrained = false
    
    lazy private var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        usernameLabel.textColor = #colorLiteral(red: 0.003920887597, green: 0.003921952564, blue: 0.003920524381, alpha: 1)
        usernameLabel.textAlignment = .left
        return usernameLabel
    }()
    
    lazy private var latestPostLabel: UILabel = {
        let latestPostLabel = UILabel()
        latestPostLabel.translatesAutoresizingMaskIntoConstraints = false
        latestPostLabel.numberOfLines = 6
        latestPostLabel.adjustsFontSizeToFitWidth = true
        latestPostLabel.font = UIFont.boldSystemFont(ofSize: 14)
        latestPostLabel.textColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        latestPostLabel.textAlignment = .justified
        return latestPostLabel
    }()
    
    lazy private var detailButton: UIButton = {
        let detailButton = UIButton()
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.backgroundColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        detailButton.setTitle("Detail", for: .normal)
        detailButton.layer.cornerRadius = 8
        detailButton.layer.masksToBounds = true
        return detailButton
    }()
    
    // MARK: - Constraints setup.
    override public class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    private func setupConstraints() {
        if !isViewConstrained {
            let contraints = [
                // Contact Image View
                contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(10)),
                contactImageView.heightAnchor.constraint(equalToConstant: CGFloat(110)),
                contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
                contactImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                // Username Label
                usernameLabel.topAnchor.constraint(equalTo: contactImageView.topAnchor),
                usernameLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                usernameLabel.heightAnchor.constraint(equalToConstant: 20),
                usernameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: CGFloat(10)),
                // Latest Post Label
                latestPostLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: CGFloat(5)),
                latestPostLabel.heightAnchor.constraint(equalToConstant: CGFloat(80)),
                latestPostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-10)),
                latestPostLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
                // Detail button
                detailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-10)),
                detailButton.widthAnchor.constraint(equalToConstant: CGFloat(100)),
                detailButton.topAnchor.constraint(equalTo: latestPostLabel.bottomAnchor, constant: CGFloat(5))
            ]
            NSLayoutConstraint.activate(contraints)
            isViewConstrained = true
        }
    }
    
}
