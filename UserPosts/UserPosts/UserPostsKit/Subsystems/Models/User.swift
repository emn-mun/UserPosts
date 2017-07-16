struct User {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    
    init?(json: Dictionary<String, Any>) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let username = json["username"] as? String,
            let email = json["email"] as? String,
            let addressJSON = json["address"] as? Dictionary<String, Any>,
            let address = Address(json: addressJSON)
            else { return nil }
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
    }
}
