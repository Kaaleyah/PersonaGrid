//
//  User.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

// User entity fetched from API
struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}
