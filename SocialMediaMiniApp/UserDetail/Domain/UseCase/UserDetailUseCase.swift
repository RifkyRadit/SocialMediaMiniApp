//
//  UserDetailUseCase.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol UserDetailDomain {
    func requestUsersData(userId: Int, completion: @escaping (Users?) -> Void)
    func requestUsersAlbum(userId: Int, completion: @escaping ([Album]) -> Void)
    func requestListPhotos(albumId: Int, completion: @escaping ([Photo]) -> Void)
}

public struct UserDetailUseCase: UserDetailDomain {
    
    private var userDetailRepository: UserDetailRepository
    
    public init(_ repository: UserDetailRepository) {
        self.userDetailRepository = repository
    }
    
    public init() {
        self.userDetailRepository = UserDetailDataRepository()
    }
    
    public func requestUsersData(userId: Int, completion: @escaping (Users?) -> Void) {
        userDetailRepository.getUsers(userId: userId) { userData in
            completion(userData)
        }
    }
    
    public func requestUsersAlbum(userId: Int, completion: @escaping ([Album]) -> Void) {
        userDetailRepository.getAlbumsUser(userId: userId) { userAlbum in
            completion(userAlbum)
        }
    }
    
    public func requestListPhotos(albumId: Int, completion: @escaping ([Photo]) -> Void) {
        userDetailRepository.getListPhotos(albumId: albumId) { listPhotos in
            completion(listPhotos)
        }
    }
}
