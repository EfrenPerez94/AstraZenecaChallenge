//
//  ContactView.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/5/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Contact View. Show contact information an a list of posts.
final class ContactView: UIView {
    
    // MARK: Public properties
    var contact: Contact? {
        didSet {
            DispatchQueue.main.async {
                self.usernameLabel.text = self.contact?.userName
                self.emailLabel.text = self.contact?.email
                self.postsDataSource.posts = self.contact?.post ?? []
                self.postsTableView.reloadData()
            }
        }
    }
    
    var contactImage: UIImage? {
        didSet {
            contactImageView.image = self.contactImage
        }
    }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes UI elements
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        addSubview(contactImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
        addSubview(postsTableView)
    }
    
    // MARK: - Private properties
    private var isViewConstrained = false
    private let postsDataSource = PostsDataSource()
    
    lazy private var contactImageView: UIImageView = {
        let contactImageView = UIImageView()
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.borderWidth = 6
        contactImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contactImageView.layer.cornerRadius = 40
        contactImageView.layer.masksToBounds = true
        return contactImageView
    }()
    
    lazy private var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        usernameLabel.textColor = #colorLiteral(red: 0.003920887597, green: 0.003921952564, blue: 0.003920524381, alpha: 1)
        usernameLabel.textAlignment = .left
        return usernameLabel
    }()
    
    lazy private var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.boldSystemFont(ofSize: 13)
        emailLabel.textColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        emailLabel.textAlignment = .left
        return emailLabel
    }()
    
    lazy private var postsTableView: UITableView = {
        let postsTableView = UITableView()
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        postsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: Constants.postCellIdentifier)
        postsTableView.dataSource = postsDataSource
        postsTableView.rowHeight = 100
        postsTableView.tableFooterView = UIView()
        return postsTableView
    }()
    
    override public class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    private func setupConstraints() {
        if !isViewConstrained {
            if #available(iOS 11.0, *) {
                let contraints = [
                    // Profile Image View
                    contactImageView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top + CGFloat(10)),
                    contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                    contactImageView.heightAnchor.constraint(equalToConstant: CGFloat(80)),
                    contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
                    // Username Label
                    usernameLabel.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 10),
                    usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                    usernameLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                    // Email Label
                    emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
                    emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                    emailLabel.widthAnchor.constraint(equalToConstant: frame.width * 0.75),
                    // Contacts TableView
                    postsTableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: CGFloat(10)),
                    postsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    postsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    postsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ]
                NSLayoutConstraint.activate(contraints)
                isViewConstrained = true
            }
        }
    }
}
