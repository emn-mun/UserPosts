struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let location: Location
    
    init?(json: Dictionary<String, Any>) {
        guard
            let street = json["street"] as? String,
            let suite = json["suite"] as? String,
            let city = json["city"] as? String,
            let zipcode = json["zipcode"] as? String,
            let locationJSON = json["geo"] as? Dictionary<String, Any>,
            let location = Location(json: locationJSON)
        else { return nil }
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.location = location
    }
}

extension Address: CustomStringConvertible {
    var description: String {
        return "\(suite), \(street), \(city), \(zipcode)"
    }
}
