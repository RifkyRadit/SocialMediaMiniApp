//
//  PostDetailRepository.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol PostDetailRepository {
    func getListComments(postId: Int, completion: @escaping ([Comment]) -> Void)
}

struct PostDetailDataRepository: PostDetailRepository {
    
    func getListComments(postId: Int, completion: @escaping ([Comment]) -> Void) {
        let pathComments = "\(postId)/comments"
        let urlString = ["https://jsonplaceholder.typicode.com/posts", pathComments].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode([Comment].self, from: data)
                completion(response)
                
            } catch {
                completion([])
            }
            
        }.resume()
    }
    
}
