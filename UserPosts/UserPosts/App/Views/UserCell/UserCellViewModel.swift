import Foundation

class UserCellViewModel: UserCellRepresentable {
    var name: String
    var userName: String
    var email: String
    var address: String
    
    init(user: User) {
        name = user.name
        userName = user.username
        email = user.email
        address = user.address.description
    }
}
