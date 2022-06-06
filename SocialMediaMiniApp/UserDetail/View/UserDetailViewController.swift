//
//  UserDetailViewController.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

protocol UserDetailViewControllerInput: AnyObject {
    func setIdUser(id: Int)
}

class UserDetailViewController: UIViewController {

    // MARK: - Properties
    private var userID: Int = 0
    private let cellIdentifier = "cell"
    private var userAlbum: [Album] = [Album]()
    private var userPhoto: [Photo] = [Photo]()
    
    lazy var viewModel: UserDetailViewModel = {
        return UserDetailViewModel()
    }()
    
    private var userData: Users? = nil {
        didSet {
            self.setUserProfile()
        }
    }
    
    // MARK: - Components
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var userProfileView: UserProfileView = {
        let view: UserProfileView = UserProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        handleStateView(state: .showIndicator)
        setupViews()
        setupLayout()
        viewModel.viewDidLoad(userId: userID)
        dataBind()
    }
    
    func dataBind() {
        viewModel.stateView = { state in
            self.handleStateView(state: state)
        }
        
        viewModel.userData = { dataUer in
            self.userData = dataUer
        }
        
        viewModel.listPhotoAlbums = { list in
            self.setupDataListAlbumPhoto(list: list)
        }
    }
}

// MARK: - Setup & Handle
extension UserDetailViewController {
    func setupViews() {
        title = Wording.titleUserDetailPage
        view.backgroundColor = Color.grayCustomBackground
        
        view.addSubview(indicatorView)
        view.addSubview(userProfileView)
        view.addSubview(tableView)
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        
        tableView.backgroundColor = .clear
        tableView.register(PhotoAlbumCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.maximumMargin),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            userProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: Margin.mainMargin),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setUserProfile() {
        guard let userData = self.userData else {
            return
        }
        
        userProfileView.setDataUserProfile(data: userData)
    }
    
    func setupDataListAlbumPhoto(list: ListAlbumPhoto?) {
        guard let list = list, !list.album.isEmpty, !list.photo.isEmpty else {
            return
        }
        
        self.userAlbum = list.album
        self.userPhoto = list.photo
        
        self.tableView.reloadData()
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            userProfileView.isHidden = true
            tableView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            userProfileView.isHidden = false
            tableView.isHidden = false
            
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PhotoAlbumCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoAlbumCell else {
            return UITableViewCell()
        }
        
        let filteredPhoto = self.userPhoto.filter({ $0.albumID == self.userAlbum[indexPath.row].id })
        
        cell.albumTitleLabel.text = self.userAlbum[indexPath.row].title
        cell.setupListPhotos(dataPhotos: filteredPhoto)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - PhotoAlbumCellDelegate
extension UserDetailViewController: PhotoAlbumCellDelegate {
    func selectedPhotoUser(data: Photo) {
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.setPhotoDetail(withData: data)
        self.navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
}

// MARK: - UserDetailViewControllerInput
extension UserDetailViewController: UserDetailViewControllerInput {
    func setIdUser(id: Int) {
        self.userID = id
    }
}
