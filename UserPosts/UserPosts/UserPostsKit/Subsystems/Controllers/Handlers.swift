protocol UsersHandler {
    func fetchUsers(completion: @escaping (Result<[User]>) -> ())
}

protocol PostsHandler {
    func fetchPosts(forUser userID: Int, completion: @escaping (Result<[Post]>) -> ())
}
