//
//  FeedUseCase.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol FeedDomain {
    func requestListPost(completion: @escaping ([Posts]) -> Void)
    func requestUsersData(completion: @escaping ([Users]) -> Void)
}

public struct FeedUseCase: FeedDomain {
    
    private var feedRepository: FeedRepository
    
    public init(_ repository: FeedRepository) {
        self.feedRepository = repository
    }
    
    public init() {
        self.feedRepository = FeedDataRepository()
    }
    
    public func requestListPost(completion: @escaping ([Posts]) -> Void) {
        self.feedRepository.getListPosts { itemPosts in
            completion(itemPosts)
        }
    }
    
    public func requestUsersData(completion: @escaping ([Users]) -> Void) {
        self.feedRepository.getUsers { usersData in
            completion(usersData)
        }
    }
}
