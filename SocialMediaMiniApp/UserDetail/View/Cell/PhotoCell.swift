//
//  PhotoCell.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    // MARK: - Components
    lazy var photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Default init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupLayout()
    }
}

// MARK: - Setup
extension PhotoCell {
    func setupView() {
        addSubview(photoImageView)
        
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.borderWidth = 2
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.layer.masksToBounds = true
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupImage(urlString: String?) {
        
        ImageDownloader.shared.setupImage(urlImage: urlString, imageView: photoImageView)
    }
}
