import Foundation

final class PostsController: PostsHandler {
    let connection: Connection
    
    init(connection: Connection) {
        self.connection = connection
    }
    
    func fetchPosts(forUser userID: Int, completion: @escaping (Result<[Post]>) -> ()) {
        connection.fetchPosts(forUser: userID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let postsData):
                    let posts = postsData.flatMap { Post(json: $0) }
                    completion(.success(posts))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
