import Foundation

final class UsersController: UsersHandler {
    let connection: Connection
    
    init(connection: Connection) {
        self.connection = connection
    }
    
    func fetchUsers(completion: @escaping (Result<[User]>) -> ()) {
        connection.fetchUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usersData):
                    let users = usersData.flatMap { User(json: $0) }
                    completion(.success(users))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
