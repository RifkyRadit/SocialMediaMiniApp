//
//  PhotoAlbumCell.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

protocol PhotoAlbumCellDelegate: AnyObject {
    func selectedPhotoUser(data: Photo)
}

class PhotoAlbumCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: PhotoAlbumCellDelegate?

    // MARK: - Components
    lazy var albumTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var listPhoto: ListPhotoView = {
        let view: ListPhotoView = ListPhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    // MARK: - Default init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayout()
    }
}

// MARK: - Setup
extension PhotoAlbumCell {
    func setupViews() {
        backgroundColor = .clear
        
        contentView.addSubview(albumTitleLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(listPhoto)
        
        listPhoto.delegate = self
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            albumTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.minimumMargin),
            albumTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.minimumMargin),
            albumTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor, constant: Margin.minimumMargin),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.minimumMargin),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.minimumMargin),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            listPhoto.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Margin.mainMargin),
            listPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            listPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin),
            listPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
    func setupListPhotos(dataPhotos: [Photo]) {
        listPhoto.setListPhotos(withData: dataPhotos)
    }
}

// MARK: - ListPhotoViewDelegate
extension PhotoAlbumCell: ListPhotoViewDelegate {
    func selectedPhoto(data: Photo) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.selectedPhotoUser(data: data)
    }
}
