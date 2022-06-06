//
//  ListPhotoView.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation
import UIKit

protocol ListPhotoViewInput: AnyObject {
    func setListPhotos(withData data: [Photo])
}

protocol ListPhotoViewDelegate: AnyObject {
    func selectedPhoto(data: Photo)
}

class ListPhotoView: UIView {
    
    // MARK: - Properties
    private var collectionHeight: CGFloat = 0
    private let cellIdentifier = "cell"
    weak var delegate: ListPhotoViewDelegate?
    
    private var listData: [Photo] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    // MARK: - Components
    lazy var listCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Default init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayouts()
    }
}

// MARK: - Setup
extension ListPhotoView {
    func setupViews() {
        backgroundColor = .clear
        
        addSubview(listCollectionView)
        
        setHeightCollectionView()
        setupCollectionView()
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            listCollectionView.heightAnchor.constraint(equalToConstant: self.collectionHeight)
        ])
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        listCollectionView.backgroundColor = .clear
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.collectionViewLayout = layout
        
        listCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setHeightCollectionView() {
        self.collectionHeight = (UIScreen.main.bounds.size.height - 64)/4
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListPhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let urlThumbnail = self.listData[indexPath.row].thumbnailURL
        cell.setupImage(urlString: urlThumbnail)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.selectedPhoto(data: self.listData[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListPhotoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height
        let width = (collectionView.bounds.width - 8)/2
        return CGSize(width:width, height: height)
    }
}

// MARK: - ListPhotoViewInput
extension ListPhotoView: ListPhotoViewInput {
    func setListPhotos(withData data: [Photo]) {
        self.listData = data
    }
}
