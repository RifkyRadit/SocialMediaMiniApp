//
//  PostDetailModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public struct Comment: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
