//
//  PostView.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation
import UIKit

protocol PostViewInput: AnyObject {
    func contentPostDetail(dataPost: FeedItems)
}

protocol PostViewDelegate: AnyObject {
    func didTapUserName()
}

class PostView: UIView {
    
    // MARK: - Properties
    weak var delegate: PostViewDelegate?
    
    // MARK: - Components
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var titlePostLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bodyPostLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Default init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayout()
    }
}

// MARK: - Setup & Action
extension PostView {
    func setupViews() {
        
        addSubview(nameLabel)
        addSubview(titlePostLabel)
        addSubview(bodyPostLabel)
        addSubview(separatorView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTapUserName(_:)))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])

        NSLayoutConstraint.activate([
            titlePostLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.mainMargin),
            titlePostLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            titlePostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            bodyPostLabel.topAnchor.constraint(equalTo: titlePostLabel.bottomAnchor, constant: Margin.minimumMargin),
            bodyPostLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            bodyPostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: bodyPostLabel.bottomAnchor, constant: Margin.maximumMargin),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc
    func actionTapUserName(_ sender: UITapGestureRecognizer) {
        guard let delegate = self.delegate else {
            return
        }

        delegate.didTapUserName()
    }
}

// MARK: - PostViewInput
extension PostView: PostViewInput {
    func contentPostDetail(dataPost: FeedItems) {
        guard let userName = dataPost.userName, let titlePost = dataPost.title, let bodyPost = dataPost.body else {
            return
        }
        
        nameLabel.text = userName
        titlePostLabel.text = titlePost
        bodyPostLabel.text = bodyPost
    }
}
