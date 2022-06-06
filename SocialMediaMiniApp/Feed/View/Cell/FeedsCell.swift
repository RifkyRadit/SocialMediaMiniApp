//
//  FeedsCell.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

class FeedsCell: UITableViewCell {
    
    // MARK: - Components
    lazy var backgroundContentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
extension FeedsCell {
    func setupViews() {
        backgroundColor = .clear
        
        backgroundContentView.layer.cornerRadius = 5
        backgroundContentView.layer.masksToBounds = true
        
        backgroundContentView.addSubview(nameLabel)
        backgroundContentView.addSubview(companyNameLabel)
        backgroundContentView.addSubview(separatorView)
        backgroundContentView.addSubview(titlePostLabel)
        backgroundContentView.addSubview(bodyPostLabel)
        
        addSubview(backgroundContentView)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            backgroundContentView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.minimumMargin),
            backgroundContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            backgroundContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin),
            backgroundContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundContentView.topAnchor, constant: Margin.minimumMargin),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor, constant: Margin.minimumMargin),
            nameLabel.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.minimumMargin),
            companyNameLabel.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor, constant: Margin.minimumMargin),
            companyNameLabel.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: Margin.minimumMargin),
            separatorView.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor, constant: Margin.minimumMargin),
            separatorView.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor, constant: -Margin.minimumMargin),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            titlePostLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Margin.mainMargin),
            titlePostLabel.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor, constant: Margin.minimumMargin),
            titlePostLabel.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            bodyPostLabel.topAnchor.constraint(equalTo: titlePostLabel.bottomAnchor, constant: Margin.minimumMargin),
            bodyPostLabel.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor, constant: Margin.minimumMargin),
            bodyPostLabel.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor, constant: -Margin.minimumMargin),
            bodyPostLabel.bottomAnchor.constraint(equalTo: backgroundContentView.bottomAnchor, constant: -Margin.minimumMargin)
        ])
    }
}
