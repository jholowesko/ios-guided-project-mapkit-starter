import Foundation



class Quake: NSObject, Decodable {
    
    /// Coding Keys
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case latitude
        case longitude
        case properties
        case geometry
        case coordinates
    }
    
    // MARK: - Properties
    
    let magnitude: Double
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double
    
    // MARK: - Init
    
    required init(from decoder: Decoder) throws {
        /// Containers
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        let geometry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        var coordinates  = try geometry.nestedUnkeyedContainer(forKey: .coordinates)
        
        /// Set each values here
        self.magnitude = try properties.decode(Double.self, forKey: .magnitude)
        self.place = try properties.decode(String.self, forKey: .place)
        self.time = try properties.decode(Date.self, forKey: .time)
        
        /// Longitude First
        self.longitude = try coordinates.decode(Double.self)
        self.latitude = try coordinates.decode(Double.self)
        
        super.init()
    }
}
