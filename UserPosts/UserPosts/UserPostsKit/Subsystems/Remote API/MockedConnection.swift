import Foundation

// This could be user for testing or for those times when the backend guys are hard at work with their API

final class MockedConnection: Connection {
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchUsers(completion: @escaping (Result<JSON>) -> ()) {
        do {
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
                throw UsersPostsError.InvalidPath
            }
            guard let data = NSData(contentsOfFile: path) else {
                throw UsersPostsError.NoData
            }
            guard let items = try JSONSerialization.jsonObject(with: data as Data, options: []) as? JSON else {
                throw UsersPostsError.JSONConversionFailed
            }
            completion(.success(items))
        } catch let error as UsersPostsError {
            completion(.failure(error))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func fetchPosts(forUser userId: Int, completion: @escaping (Result<JSON>) -> ()) {
        do {
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
                throw UsersPostsError.InvalidPath
            }
            guard let data = NSData(contentsOfFile: path) else {
                throw UsersPostsError.NoData
            }
            guard let items = try JSONSerialization.jsonObject(with: data as Data, options: []) as? JSON else {
                throw UsersPostsError.JSONConversionFailed
            }
            completion(.success(items))
        } catch let error as UsersPostsError {
            completion(.failure(error))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
