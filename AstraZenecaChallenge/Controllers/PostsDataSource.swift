//
//  PostsDataSource.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/5/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table view data source
final class PostsDataSource: NSObject, UITableViewDataSource {
    
    var posts: [Post] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: Constants.postCellIdentifier, for: indexPath) as? PostTableViewCell else {
            fatalError("Unable cast cell as PostTableViewCell")
        }
        
        postCell.post = posts[indexPath.row]
        return postCell
    }
}
