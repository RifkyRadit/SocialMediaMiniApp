//
//  UserDetailRepository.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

public protocol UserDetailRepository {
    func getUsers(userId: Int, completion: @escaping (Users?) -> Void)
    func getAlbumsUser(userId: Int, completion: @escaping ([Album]) -> Void)
    func getListPhotos(albumId: Int, completion: @escaping ([Photo]) -> Void)
}

struct UserDetailDataRepository: UserDetailRepository {
    
    func getUsers(userId: Int, completion: @escaping (Users?) -> Void) {
        let userId = String(userId)
        let urlString = ["https://jsonplaceholder.typicode.com/users", userId].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(Users.self, from: data)
                completion(response)
                
            } catch {
                completion(nil)
            }
            
        }.resume()
    }
    
    func getAlbumsUser(userId: Int, completion: @escaping ([Album]) -> Void) {
        let userId = String(userId)
        let urlString = ["https://jsonplaceholder.typicode.com/users", userId, "albums"].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode([Album].self, from: data)
                completion(response)
                
            } catch {
                completion([])
            }
            
        }.resume()
    }
    
    func getListPhotos(albumId: Int, completion: @escaping ([Photo]) -> Void) {
        let albumId = String(albumId)
        let urlString = ["https://jsonplaceholder.typicode.com/albums", albumId, "photos"].joined(separator: "/")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode([Photo].self, from: data)
                completion(response)
                
            } catch {
                completion([])
            }
            
        }.resume()
    }
}
