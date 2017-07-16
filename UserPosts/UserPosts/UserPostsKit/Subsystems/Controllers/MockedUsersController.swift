import Foundation

final class MockedUsersController: UsersHandler {
    func fetchUsers(completion: @escaping (Result<[User]>) -> ()) {
        MockedConnection(fileName: "usersData").fetchUsers { result in
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
