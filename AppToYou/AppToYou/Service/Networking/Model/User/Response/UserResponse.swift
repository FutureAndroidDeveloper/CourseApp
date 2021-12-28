import Foundation


class UserResponse: UserPublicResponse {
    var loginEmailAddress: String
    var createdTimestamp: String?
    var updatedTimestamp: String?
    
    init(name: String, loginEmailAddress: String, id: Int? = nil, avatarPath: String? = nil,
         createdTimestamp: String? = nil, updatedTimestamp: String? = nil) {
        self.loginEmailAddress = loginEmailAddress
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
        super.init(name: name, id: id, avatarPath: avatarPath)
    }
    
    private enum CodingKeys: String, CodingKey {
        case loginEmailAddress
        case createdTimestamp
        case updatedTimestamp
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(loginEmailAddress, forKey: .loginEmailAddress)
        try? container.encode(createdTimestamp, forKey: .createdTimestamp)
        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
        
        try super.encode(to: encoder)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        loginEmailAddress = try container.decode(String.self, forKey: .loginEmailAddress)
        createdTimestamp = try? container.decode(String.self, forKey: .createdTimestamp)
        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
        
        try super.init(from: decoder)
    }
    
}
