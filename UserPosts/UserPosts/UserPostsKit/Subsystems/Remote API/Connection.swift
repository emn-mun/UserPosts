import Foundation

public typealias JSON = [Dictionary<String, Any>]

public enum Result<ValueType> {
    case success(ValueType)
    case failure(Error)
    
    public var value: ValueType? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

public enum UsersPostsError: Error {
    case NoHTTPResponse
    case HTTPError(statusCode: Int, errorDescription: String?)
    case NoData
    case JSONConversionFailed
    case InvalidPath
}

public enum URLPaths: String {
    case users = "https://jsonplaceholder.typicode.com/users"
    case posts = "https://jsonplaceholder.typicode.com/posts?userId="
}

protocol Connection {
    func fetchUsers(completion: @escaping (Result<JSON>) -> ())
    func fetchPosts(forUser userId: Int, completion: @escaping (Result<JSON>) -> ())
}
