//
//  UsersDataSource.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table view data source
final class ContactsDataSource: NSObject, UITableViewDataSource {
    
    var contacts: [Contact] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: Constants.contactCellIdentifier, for: indexPath) as? ContactTableViewCell else {
            fatalError("Unable cast cell as ContactTableViewCell")
        }
        contactCell.contactImageView.image = Constants.profileImage[indexPath.row]
        contactCell.contact = contacts[indexPath.row]
        
        /// Closure detail action
        contactCell.buttonDetailTap = { () in
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            let main = ContactViewController(with: self.contacts[indexPath.row], index: indexPath.row)
            navigationController?.pushViewController(main, animated: false)
        }
        return contactCell
    }
}
