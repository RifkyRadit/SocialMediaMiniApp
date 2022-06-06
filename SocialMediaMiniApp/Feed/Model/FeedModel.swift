//
//  FeedModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public struct FeedItems {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?
    let userName: String?
    let companyName: String?
    
    init(id: Int = 0, userId: Int = 0, title: String = "", body: String = "", userName: String = "", companyName: String = "") {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.userName = userName
        self.companyName = companyName
    }
}

// MARK: - Posts
public struct Posts: Codable {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case id, userId, title, body
    }
}
