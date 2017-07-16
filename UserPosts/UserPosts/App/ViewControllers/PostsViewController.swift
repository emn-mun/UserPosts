import UIKit

class PostsViewController: UITableViewController {
    private let userId: Int
    private var posts: [Post] = []
    private let postCellID = "postCellID"
    private let postsHandler: PostsHandler
    
    init(userId: Int, postsHandler: PostsHandler) {
        self.userId = userId
        self.postsHandler = postsHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Posts"
        tableView.allowsSelection = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postCellID)
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: UITableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellID) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.cellViewModel = PostCellViewModel(post: post)
        return cell
    }
    
    // MARK: Private methods
    private func updateTableView() {
        postsHandler.fetchPosts(forUser: userId) {[weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }

}
