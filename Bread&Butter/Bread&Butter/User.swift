//
//  User.swift
//  Bread&Butter
//
//  Created by Oliwier Kasprzak on 27/02/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
    

}

struct Friend: Codable {
    var id: UUID
    var name: String
}
