//
//  UserProfileView.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import Foundation
import UIKit

protocol UserProfileViewInput: AnyObject {
    func setDataUserProfile(data: Users)
}

class UserProfileView: UIView {
    
    // MARK: - Components
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

// MARK: - Setup
extension UserProfileView {
    func setupViews() {
        backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        addSubview(nameLabel)
        addSubview(companyNameLabel)
        addSubview(emailLabel)
        addSubview(addressLabel)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.maximumMargin),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.minimumMargin),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: Margin.minimumMargin),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Margin.mainMargin),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.maximumMargin)
        ])
    }
    
    private func setupAddress(userAddress: Address) {
        guard let userStreet = userAddress.street, let userSuite = userAddress.suite, let userCity = userAddress.city, let userZipCode = userAddress.zipcode else {
            return
        }
        
        let street = [Wording.street, userStreet].joined(separator: " ")
        let suite = [Wording.suite, userSuite].joined(separator: " ")
        let city = [Wording.city, userCity].joined(separator: " ")
        let zipCode = [Wording.zipCode, userZipCode].joined(separator: " ")
        
        let address = [street, suite, city, zipCode].joined(separator: " | ")
        addressLabel.text = address
    }
}

// MARK: - UserProfileViewInput
extension UserProfileView: UserProfileViewInput {
    func setDataUserProfile(data: Users) {
        guard let userName = data.name, let email = data.email, let company = data.company, let companyName = company.name, let address = data.address else {
            return
        }
        
        nameLabel.text = userName
        companyNameLabel.text = companyName
        emailLabel.text = email
        setupAddress(userAddress: address)
    }
}
