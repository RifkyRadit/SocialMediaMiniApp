//
//  UserModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

// MARK: - Users
public struct Users: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

public struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

public struct Geo: Codable {
    let lat, lng: String?
}

public struct Company: Codable {
    let name, catchPhrase, bs: String?
}
