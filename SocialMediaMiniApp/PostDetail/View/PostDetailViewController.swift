//
//  PostDetailViewController.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 04/06/22.
//

import UIKit

protocol PostDetailViewControllerInput: AnyObject {
    func setContentPostDetail(data: FeedItems)
}

class PostDetailViewController: PostDetailBaseViewController {

    // MARK: - Properties
    let cellIdentifier = "cell"
    
    lazy var viewModel: PostDetailViewModel = {
        return PostDetailViewModel()
    }()
    
    private var dataPost: FeedItems? = nil {
        didSet {
            setupPostDetail()
        }
    }
    
    private var listComments: [Comment] = [Comment]() {
        didSet {
            setupComment()
        }
    }
    
    // MARK: - Life Cycle & Override function
    override func viewDidLoad() {
        super.viewDidLoad()

        handleStateView(state: .showIndicator)
        setupViews()
        setupLayout()
        viewModel.viewDidLoad(postId: dataPost?.id ?? 0)
        setupTableViewProperties()
        dataBind()
    }
    
    func dataBind() {
        viewModel.stateView = { state in
            self.handleStateView(state: state)
        }
        
        viewModel.listComments = { items in
            self.listComments = items
        }
    }
    
    override func actionTapUserName() {
        guard let dataPost = dataPost, let userId = dataPost.userId else {
            return
        }
        
        let userDetailViewController = UserDetailViewController()
        userDetailViewController.setIdUser(id: userId)
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}

// MARK: - Setup & Handle
extension PostDetailViewController {
    func setupTableViewProperties() {
        tableView.register(CommentCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.backgroundColor = .clear
    }
    
    func setupPostDetail() {
        guard let dataPost = self.dataPost else {
            return
        }
        
        postView.contentPostDetail(dataPost: dataPost)
    }
    
    func setupComment() {
        let countComment = String(self.listComments.count)
        self.commentLabel.text = [Wording.titleComment, countComment].joined(separator: " ")
        
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CommentCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        
        guard let authorName = listComments[indexPath.row].name, let bodyComment = listComments[indexPath.row].body else {
            return UITableViewCell()
        }
        
        cell.authorNameLabel.text = authorName
        cell.bodyCommentLabel.text = bodyComment
        
        return cell
    }
}

// MARK: - PostDetailViewControllerInput
extension PostDetailViewController: PostDetailViewControllerInput {
    func setContentPostDetail(data: FeedItems) {
        self.dataPost = data
    }
}
