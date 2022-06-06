//
//  PostDetailBaseViewController.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

class PostDetailBaseViewController: UIViewController, PostViewDelegate {

    // MARK: - Properties
    private var tableViewHeight: NSLayoutConstraint!
    
    open func actionTapUserName() { }
    
    // MARK: - Components
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var postView: PostView = {
        let view: PostView = PostView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
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

        // Do any additional setup after loading the view.
    }
    
    func didTapUserName() {
        actionTapUserName()
    }
}

// MARK: - Setup & Handle
extension PostDetailBaseViewController {
    func setupViews() {

        title = Wording.titlePostDetailPage
        view.backgroundColor = .white
        
        view.addSubview(indicatorView)
        view.addSubview(postView)
        view.addSubview(commentLabel)
        view.addSubview(separatorView)
        view.addSubview(tableView)
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        
        postView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: postView.bottomAnchor, constant: Margin.minimumMargin),
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            commentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: Margin.minimumMargin),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Margin.mainMargin),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            postView.isHidden = true
            commentLabel.isHidden = true
            separatorView.isHidden = true
            tableView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            postView.isHidden = false
            commentLabel.isHidden = false
            separatorView.isHidden = false
            tableView.isHidden = false
            
        }
    }
}
