//
//  FeedViewModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation


protocol FeedViewModelInput {
    func viewDidLoad()
}

class FeedViewModel: FeedViewModelInput {
    
    private var feedUseCase = FeedUseCase()
    private var listPosts = [Posts]()
    private var usersData = [Users]()
    
    var stateView: (StateView) -> () = { _ in }
    var productItems: ([FeedItems]) -> () = { _ in }
    
    func viewDidLoad() {
        getListPost()
        getUserData()
        setupItemPosts()
    }
}

private extension FeedViewModel {
    func getListPost() {
        
        feedUseCase.requestListPost { itemPosts in
            DispatchQueue.main.async {
                
                guard !itemPosts.isEmpty else {
                    return
                }
                
                self.listPosts = itemPosts
            }
        }
    }
    
    func getUserData() {
        feedUseCase.requestUsersData { usersData in
            DispatchQueue.main.async {
                
                guard !usersData.isEmpty else {
                    return
                }
                
                self.usersData = usersData
            }
        }
    }
    
    func setupItemPosts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            var feedItems = [FeedItems]()
            
            self.listPosts.forEach { post in
                
                guard let postId = post.id, let userId = post.userId, let postTitle = post.title, let postBody = post.body, let indexItem = self.usersData.firstIndex(where: {$0.id == userId}) else {
                    return
                }
                
                guard let userName = self.usersData[indexItem].name, let company = self.usersData[indexItem].company, let companyName = company.name else {
                    return
                }
                
                feedItems.append(FeedItems(id: postId,
                                           userId: userId,
                                           title: postTitle,
                                           body: postBody,
                                           userName: userName,
                                           companyName: companyName))
            }
            
            self.productItems(feedItems)
            self.stateView(.showContent)
        }
    }
}
