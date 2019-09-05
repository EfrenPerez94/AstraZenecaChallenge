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
    var profileImage = [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4"), #imageLiteral(resourceName: "Image5"), #imageLiteral(resourceName: "Image6")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: Constants.contactCellIdentifier, for: indexPath) as? ContactTableViewCell else {
            fatalError("Unable cast cell as LanguageTableViewCell")
        }
        contactCell.contactImageView.image = profileImage[indexPath.row]
        contactCell.contact = contacts[indexPath.row]
        
        contactCell.buttonDetailTap = { () in
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            let main = ContactViewController()
            navigationController?.pushViewController(main, animated: false)
        }
        return contactCell
    }
}
