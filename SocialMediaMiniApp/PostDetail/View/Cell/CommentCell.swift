//
//  CommentCell.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

class CommentCell: UITableViewCell {

    // MARK: - Components
    lazy var authorNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundCommentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bodyCommentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

// MARK: - Setup & Handle
extension CommentCell {
    func setupViews() {
        backgroundCommentView.addSubview(bodyCommentLabel)
        
        addSubview(authorNameLabel)
        addSubview(backgroundCommentView)
        
        backgroundCommentView.layer.cornerRadius = 5
        backgroundCommentView.layer.masksToBounds = true
        backgroundCommentView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
        ])
        
        NSLayoutConstraint.activate([
            backgroundCommentView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Margin.minimumMargin),
            backgroundCommentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            backgroundCommentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
            backgroundCommentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            bodyCommentLabel.topAnchor.constraint(equalTo: backgroundCommentView.topAnchor, constant: Margin.minimumMargin),
            bodyCommentLabel.leadingAnchor.constraint(equalTo: backgroundCommentView.leadingAnchor, constant: Margin.minimumMargin),
            bodyCommentLabel.trailingAnchor.constraint(equalTo: backgroundCommentView.trailingAnchor, constant: -Margin.minimumMargin),
            bodyCommentLabel.bottomAnchor.constraint(equalTo: backgroundCommentView.bottomAnchor, constant: -Margin.minimumMargin)
        ])
    }
}
