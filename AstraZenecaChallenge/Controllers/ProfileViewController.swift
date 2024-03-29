//
//  ViewController.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import UIKit

/// Porifle View Controller, initial view with profile information.
final class ProfileViewController: UIViewController, ProfileViewDelegate {

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
    
    // MARK: - Data load
    fileprivate func loadContacts() {
        let localPath = Bundle.main.path(forResource: "user", ofType: "json")
        guard let path = localPath else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        let repository = AstraRepository()
        repository.execute(JsonData.self, url: url) { [weak self] result in
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
    
    fileprivate func functionalityAlert() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "Sorry, this functionality is not available",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - Profile View Delegate
extension ProfileViewController {
    func profileView(_ profileView: ProfileView, didTapAdd button: UIButton) {
        functionalityAlert()
    }
    
    func profileView(_ profileView: ProfileView, didTapSettings button: UIButton) {
        functionalityAlert()
    }
}
