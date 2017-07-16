struct Post {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    init?(json: Dictionary<String, Any>) {
        guard
            let id = json["id"] as? Int,
            let userId = json["userId"] as? Int,
            let title = json["title"] as? String,
            let body = json["body"] as? String
            else { return nil }
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}
