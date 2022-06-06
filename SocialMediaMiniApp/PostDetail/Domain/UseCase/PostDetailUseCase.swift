//
//  PostDetailUseCase.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol PostDetailDomain {
    func requestListComments(withId postId: Int, completion: @escaping ([Comment]) -> Void)
}

public struct PostDetailUseCase: PostDetailDomain {
    
    private var postDetailRepository: PostDetailRepository
    
    public init(_ repository: PostDetailRepository) {
        self.postDetailRepository = repository
    }
    
    public init() {
        self.postDetailRepository = PostDetailDataRepository()
    }
    
    public func requestListComments(withId postId: Int, completion: @escaping ([Comment]) -> Void) {
        self.postDetailRepository.getListComments(postId: postId) { comments in
            completion(comments)
        }
    }
}
