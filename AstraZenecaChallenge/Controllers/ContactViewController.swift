//
//  ContactViewController.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/5/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import UIKit

/// Contact View Controller, manage detail for a specific contact.
final class ContactViewController: UIViewController {
    
    let contactView = ContactView()
    let contact: Contact
    let index: Int
    
    // MARK: - Initializers
    init(with contact: Contact, index: Int) {
        self.contact = contact
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life View Cycle
    override func loadView() {
        self.view = contactView
        contactView.contactImage = Constants.profileImage[index]
        contactView.contact = contact
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contact.post?.isEmpty ?? true {
            let alert = UIAlertController(title: "Ops!",
                                          message: "\(contact.userName) has no posts yet",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
}
