import Foundation


class UserPublicResponse: Codable {
    var name: String
    var id: Int?
    var avatarPath: String?
    
    init(name: String, id: Int? = nil, avatarPath: String? = nil) {
        self.name = name
        self.id = id
        self.avatarPath = avatarPath
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case avatarPath
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try? container.encode(id, forKey: .id)
        try? container.encode(avatarPath, forKey: .avatarPath)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        id = try? container.decode(Int.self, forKey: .id)
        avatarPath = try? container.decode(String.self, forKey: .avatarPath)
    }
    
}
