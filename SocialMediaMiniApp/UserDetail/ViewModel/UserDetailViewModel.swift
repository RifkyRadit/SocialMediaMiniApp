//
//  UserDetailViewModel.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation

protocol UserDetailViewModelInput {
    func viewDidLoad(userId: Int)
}

class UserDetailViewModel: UserDetailViewModelInput {
    
    private var userDetailUseCase = UserDetailUseCase()
    
    var userData: (Users?) -> () = { _ in }
    var listPhotoAlbums: (ListAlbumPhoto?) -> () = { _ in }
    var stateView: (StateView) -> () = { _ in }
    var albums: [Album] = []
    var photos: [Photo] = []
    
    func viewDidLoad(userId: Int) {
        getUserData(userId: userId)
        getUserAlbums(userId: userId)
        getAllData()
    }
}

private extension UserDetailViewModel {
    func getUserData(userId: Int) {
        userDetailUseCase.requestUsersData(userId: userId) { userData in
            DispatchQueue.main.async {
                self.userData(userData)
            }
        }
    }
    
    func getUserAlbums(userId: Int) {
        userDetailUseCase.requestUsersAlbum(userId: userId) { userAlbum in
            DispatchQueue.main.async {
                
                guard !userAlbum.isEmpty else {
                    return
                }
                
                self.albums = userAlbum
                userAlbum.forEach { album in
                    self.getListPhotos(albumId: album.id)
                }
            }
        }
    }
    
    func getListPhotos(albumId: Int) {
        userDetailUseCase.requestListPhotos(albumId: albumId) { listPhotos in
            guard !listPhotos.isEmpty else {
                return
            }
            
            self.photos.append(contentsOf: listPhotos)
        }
    }
    
    func getAllData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let listAlbumPhoto = ListAlbumPhoto(photo: self.photos, album: self.albums)
            self.listPhotoAlbums(listAlbumPhoto)
            self.stateView(.showContent)
        }
    }
 }
