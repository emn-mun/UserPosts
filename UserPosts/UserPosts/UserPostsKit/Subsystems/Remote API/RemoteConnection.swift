import Foundation

class RemoteConnection: Connection {
    func fetchUsers(completion: @escaping (Result<JSON>) -> ()) {
        requestTask(with: URLRequest(url: URL(string: URLPaths.users.rawValue)!), completion: { result, response in
            switch result {
            case .success(let data):
                do {
                    guard let items = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
                        throw UsersPostsError.JSONConversionFailed
                    }
                    completion(.success(items))
                } catch let error as UsersPostsError {
                    completion(.failure(error))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }).resume()
    }
    
    func fetchPosts(forUser userId: Int, completion: @escaping (Result<JSON>) -> ()) {
        let pathString = "\(URLPaths.posts.rawValue)\(userId)"
        requestTask(with: URLRequest(url: URL(string: pathString)!), completion: { result, response in
            switch result {
            case .success(let data):
                do {
                    guard let items = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
                        throw UsersPostsError.JSONConversionFailed
                    }
                    completion(.success(items))
                } catch let error as UsersPostsError {
                    completion(.failure(error))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }).resume()
    }
    
    private func requestTask(with urlRequest: URLRequest, completion: @escaping (Result<Data>, HTTPURLResponse?) -> ()) -> URLSessionTask {
        return URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                return completion(.failure(error!), response as? HTTPURLResponse)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(UsersPostsError.NoHTTPResponse), response as? HTTPURLResponse)
            }
            guard let returnedData = data else {
                return completion(.failure(UsersPostsError.NoData), httpResponse)
            }
            guard(200...299).contains(httpResponse.statusCode) else {
                let responseBody: String?
                if let data = data {
                    responseBody = String(data: data, encoding: .utf8)
                } else {
                    responseBody = nil
                }
                return completion(.failure(UsersPostsError.HTTPError(statusCode: httpResponse.statusCode, errorDescription: responseBody)), httpResponse)
            }
            completion(.success(returnedData), httpResponse)
        }
    }
}
