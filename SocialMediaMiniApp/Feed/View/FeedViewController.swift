//
//  FeedViewController.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 03/06/22.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - Properties
    private let cellIdentifier = "cell"
    
    private var feedItems: [FeedItems] = [FeedItems]() {
        didSet {
            self.reloadTableView()
        }
    }
    
    lazy var viewModel: FeedViewModel = {
        return FeedViewModel()
    }()
    
    // MARK: - Components
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        viewModel.viewDidLoad()
        dataBind()
    }
    
    func dataBind() {
        viewModel.stateView = { state in
            self.handleStateView(state: state)
        }
        
        viewModel.productItems = { items in
            self.feedItems = items
        }
    }
}

// MARK: - Setup & Handle
extension FeedViewController {
    func setupViews() {
        title = Wording.titleFeedPage
        view.backgroundColor = Color.grayCustomBackground
        
        view.addSubview(indicatorView)
        view.addSubview(tableView)
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        
        tableView.backgroundColor = .clear
        tableView.register(FeedsCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            tableView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            tableView.isHidden = false
            
        }
    }
    
    func navigateToDetail(dataPost: FeedItems) {
        let postDetailViewController = PostDetailViewController()
        postDetailViewController.setContentPostDetail(data: dataPost)
        self.navigationController?.pushViewController(postDetailViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FeedsCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FeedsCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = feedItems[indexPath.row].userName
        cell.companyNameLabel.text = feedItems[indexPath.row].companyName
        cell.titlePostLabel.text = feedItems[indexPath.row].title
        cell.bodyPostLabel.text = feedItems[indexPath.row].body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetail(dataPost: self.feedItems[indexPath.row])
    }
}
