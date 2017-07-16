import Foundation

final class MockedPostsController: PostsHandler {
    func fetchPosts(forUser userId: Int, completion: @escaping (Result<[Post]>) -> ()) {
        MockedConnection(fileName: "postsData").fetchPosts(forUser: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let postsData):
                    let posts = postsData.flatMap { Post(json: $0) }.filter { $0.userId == userId }
                    completion(.success(posts))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
