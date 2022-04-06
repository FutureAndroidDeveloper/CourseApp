import Foundation


class TaskResponse: Codable {
    var id: Int?
    var createdTimestamp: String?
    var updatedTimestamp: String?
    
    init(id: Int? = nil, createdTimestamp: String? = nil, updatedTimestamp: String? = nil) {
        self.id = id
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdTimestamp
        case updatedTimestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        createdTimestamp = try? container.decode(String.self, forKey: .createdTimestamp)
        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(id, forKey: .id)
        try? container.encode(createdTimestamp, forKey: .createdTimestamp)
        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
    }
}
