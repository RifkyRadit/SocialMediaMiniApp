//
//  UserDetailModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public struct Album: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

public struct Photo: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

public struct ListAlbumPhoto {
    let photo: [Photo]
    let album: [Album]
    
    init(photo: [Photo] = [], album: [Album] = []) {
        self.photo = photo
        self.album = album
    }
}
