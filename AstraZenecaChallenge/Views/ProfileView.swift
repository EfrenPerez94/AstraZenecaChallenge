//
//  ProfileView.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// `ProfileView` delegate
protocol ProfileViewDelegate: class {
    func profileView(_ profileView: ProfileView, didTapAdd button: UIButton)
    func profileView(_ profileView: ProfileView, didTapSettings button: UIButton)
}

/// Profile View. Show profile information an a list of contacts.
final class ProfileView: UIView {
    
    // MARK: Public properties
    var contacts: [Contact]? {
        didSet {
            DispatchQueue.main.async {
                self.contactsDataSource.contacts = self.contacts ?? []
                self.contactsTableView.reloadData()
            }
        }
    }
    
    lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        addButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        return addButton
    }()
    
    lazy var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
        settingsButton.backgroundColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.layer.cornerRadius = 8
        settingsButton.layer.masksToBounds = true
        return settingsButton
    }()
    
    // MARK: Internal properties
    weak var delegate: ProfileViewDelegate?
    
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
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
        addSubview(contactsTableView)
        // Actions
        addButton.addTarget(self, action: #selector(addTouchUpInside(_:)), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTouchUpInside(_:)), for: .touchUpInside)
    }
    
    // MARK: WelcomeView delegates
    @objc func addTouchUpInside(_ sender: UIButton) {
        delegate?.profileView(self, didTapAdd: sender)
    }
    
    @objc func settingsTouchUpInside(_ sender: UIButton) {
        delegate?.profileView(self, didTapSettings: sender)
    }
    
    // MARK: - Private properties
    private var isViewConstrained = false
    private let contactsDataSource = ContactsDataSource()
    
    lazy private var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.borderWidth = 6
        profileImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.masksToBounds = true
        profileImageView.image = #imageLiteral(resourceName: "profile")
        return profileImageView
    }()
    
    lazy private var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        usernameLabel.textColor = #colorLiteral(red: 0.003920887597, green: 0.003921952564, blue: 0.003920524381, alpha: 1)
        usernameLabel.textAlignment = .center
        usernameLabel.text = "EfrenPB"
        return usernameLabel
    }()
    
    lazy private var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        emailLabel.textColor = #colorLiteral(red: 0.4234947264, green: 0.423548907, blue: 0.423476398, alpha: 1)
        emailLabel.textAlignment = .center
        emailLabel.text =  "pb.efren@gmail.com"
        return emailLabel
    }()
    
    lazy private var contactsTableView: UITableView = {
        let contactsTableView = UITableView()
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: Constants.contactCellIdentifier)
        contactsTableView.rowHeight = 200
        contactsTableView.dataSource = contactsDataSource
        contactsTableView.tableFooterView = UIView()
        return contactsTableView
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
                    profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top + 10),
                    profileImageView.heightAnchor.constraint(equalToConstant: 120),
                    profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
                    profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    // Username Label
                    usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
                    usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                    usernameLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                    // Email Label
                    emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
                    emailLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                    emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                    // Contacts TableView
                    contactsTableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: CGFloat(10)),
                    contactsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    contactsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    contactsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ]
                NSLayoutConstraint.activate(contraints)
                isViewConstrained = true
            }
        }
    }
}
