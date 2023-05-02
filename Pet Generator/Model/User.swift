//
//  User.swift
//  Pet Generator
//
//  Created by Vitor Sousa on 01/05/2023.
//

import Foundation

struct UserApiData: Decodable {
    var results: [User]
}

struct User: Decodable {
    var gender: String
    var name: Name
    var dob: Birthdate
}

struct Name: Decodable {
    var first: String
    var last: String
}

struct Birthdate: Decodable {
    var age: Int
}

