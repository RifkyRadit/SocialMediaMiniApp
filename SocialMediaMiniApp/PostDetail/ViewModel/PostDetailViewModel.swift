//
//  PostDetailViewModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

protocol PostDetailViewModelInput {
    func viewDidLoad(postId: Int)
}

class PostDetailViewModel: PostDetailViewModelInput {
    
    private var postDetailUseCase = PostDetailUseCase()
    
    var stateView: (StateView) -> () = { _ in }
    var listComments: ([Comment]) -> () = { _ in }
    
    func viewDidLoad(postId: Int) {
        getListComment(withId: postId)
    }
}

private extension PostDetailViewModel {
    func getListComment(withId postId: Int) {
        self.postDetailUseCase.requestListComments(withId: postId) { itemComments in
            
            DispatchQueue.main.async {
                
                guard !itemComments.isEmpty else {
                    return
                }
                
                self.listComments(itemComments)
                self.stateView(.showContent)
            }
        }
    }
}
