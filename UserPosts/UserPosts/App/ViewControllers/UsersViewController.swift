import UIKit

class UsersViewController: UITableViewController {
    private var users: [User] = []
    private let userCellID = "masterCellID"
    private let usersHandler: UsersHandler
    
    init(usersHandler: UsersHandler) {
        self.usersHandler = usersHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Users"
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: userCellID)
        
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: UITableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellID) as! UserTableViewCell
        cell.cellViewModel = UserCellViewModel(user: users[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id
        let postsViewController = PostsViewController(userId: userId, postsHandler: PostsController(connection: RemoteConnection()))
        navigationController?.pushViewController(postsViewController, animated: true)
    }
    
    // MARK: Private methods
    private func updateTableView() {
        usersHandler.fetchUsers {[weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
