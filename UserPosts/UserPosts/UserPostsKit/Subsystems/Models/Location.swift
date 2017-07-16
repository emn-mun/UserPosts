struct Location {
    let latitude: Double
    let longitude: Double
    
    init?(json: Dictionary<String, Any>) {
        guard
            let latitudeString = json["lat"] as? String,
            let longitudeString = json["lng"] as? String,
            let latitude = Double(latitudeString),
            let longitude = Double(longitudeString)
            else { return nil }
        self.latitude = latitude
        self.longitude = longitude
    }
}
