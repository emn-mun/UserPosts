import UIKit

extension UserTableViewCell: CellConfigurable {
    // Associated type ViewModel -> UserCellViewModel in our case
}

class UserTableViewCell: UITableViewCell {

    var cellViewModel: UserCellViewModel? {
        didSet {
            guard let cellViewModel = cellViewModel else { return }
            userView.nameLabel.text = cellViewModel.name
            userView.userNameLabel.text = cellViewModel.userName
            userView.emailLabel.text = cellViewModel.email
            userView.addressLabel.text = cellViewModel.address
        }
    }

    let userView = UserView()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        userView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userView)
        
        NSLayoutConstraint.activate([
            userView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userView.topAnchor.constraint(equalTo: topAnchor),
            userView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
