//
//  Data.swift
//  AstraZenecaChallenge
//
//  Created by Efrén Pérez Bernabe on 9/3/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Data struct to store data retrieve from json.
struct AstraData: Codable {
    let data: Data
}

struct Data: Codable {
    let user: [Contact]
}

/// User struct to store data retrieve from json.
struct Contact: Codable {
    let userId: String
    let lastName: String
    let firstName: String
    let department: String
    let email: String
    let userName: String
    let post: [Post]?
}

/// Post struct to store data retrieve from json.
struct Post: Codable {
    let title: String
    let content: String
}
