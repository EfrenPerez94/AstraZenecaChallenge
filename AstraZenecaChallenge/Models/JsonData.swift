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
struct JsonData: Codable {
    let data: Data
}

struct Data: Codable {
    let user: [Contact]
}

/// Contact struct to store data retrieve from json.
struct Contact: Codable {
    let email: String
    let userName: String
    let post: [Post]?
}

/// Post struct to store data retrieve from json.
struct Post: Codable {
    let title: String
    let content: String
}
