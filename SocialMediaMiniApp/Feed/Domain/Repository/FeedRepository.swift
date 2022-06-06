//
//  FeedRepository.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol FeedRepository {
    func getListPosts(completion: @escaping ([Posts]) -> Void)
    func getUsers(completion: @escaping ([Users]) -> Void)
}

struct FeedDataRepository: FeedRepository {
    
    public func getListPosts(completion: @escaping ([Posts]) -> Void) {
        let urlString = [urlApi.baseUrl, urlApi.postsUrlPath].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode([Posts].self, from: data)
                completion(response)
                
            } catch {
                completion([])
            }
            
        }.resume()
    }
    
    func getUsers(completion: @escaping ([Users]) -> Void) {
        let urlString = [urlApi.baseUrl, urlApi.usersUrlPath].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode([Users].self, from: data)
                completion(response)
                
            } catch {
                completion([])
            }
            
        }.resume()
    }
}
