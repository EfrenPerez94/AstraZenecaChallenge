//
//  ViewController.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewDelegate {

    let profileView = ProfileView()
    
    // MARK: - Life View Cycle
    override func loadView() {
        profileView.delegate = self
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: profileView.addButton), UIBarButtonItem(customView: profileView.settingsButton) ]
        loadContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data load
    fileprivate func loadContacts() {
        let localPath = Bundle.main.path(forResource: "user", ofType: "json")
        guard let path = localPath else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        let repository = AstraRepository()
        repository.execute(AstraData.self, url: url) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let astraData):
                weakSelf.profileView.contacts = astraData.data.user
            case .failure(let error):
                let alert = UIAlertController(title: "Something happened",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                weakSelf.present(alert, animated: true)
            }
        }
    }
    
    fileprivate func opsAlert() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "Sorry, this functionality is not available",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - Welcome View Delegate
extension ProfileViewController {
    func profileView(_ profileView: ProfileView, didTapAdd button: UIButton) {
        opsAlert()
    }
    
    func profileView(_ profileView: ProfileView, didTapSettings button: UIButton) {
        opsAlert()
    }
}

// MARK: - Table View Delegate
extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
