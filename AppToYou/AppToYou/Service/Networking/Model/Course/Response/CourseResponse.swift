import Foundation


class CourseResponse: CourseCreateRequest {
    var admin: UserPublicResponse
    var coinPrice: Int
    var createdTimestamp: String
    var diamondPrice: Int
    var id: Int
    var isInternal: Bool
    var likes: Int
    var isOpen: Bool
    var publicId: String?
    var updatedTimestamp: String?
    var usersAmount: Int
    
    init(createCourseRequest: CourseCreateRequest, admin: UserPublicResponse, coinPrice: Int, createdTimestamp: String, diamondPrice: Int, id: Int, isInternal: Bool, likes: Int, isOpen: Bool, updatedTimestamp: String, usersAmount: Int) {
        self.admin = admin
        self.coinPrice = coinPrice
        self.createdTimestamp = createdTimestamp
        self.diamondPrice = diamondPrice
        self.id = id
        self.isInternal = isInternal
        self.likes = likes
        self.isOpen = isOpen
        self.updatedTimestamp = updatedTimestamp
        self.usersAmount = usersAmount
        
        let model = createCourseRequest
        super.init(
            name: model.name, description: model.description, courseCategory1: model.courseCategory1,
            courseCategory2: model.courseCategory2, courseCategory3: model.courseCategory3, courseType: model.courseType,
            durationType: model.durationType, privacyEnabled: model.privacyEnabled, picPath: model.picPath,
            price: model.price, duration: model.duration, chatPath: model.chatPath)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case admin
        case id, publicId
        case coinPrice, diamondPrice
        case createdTimestamp, updatedTimestamp
        case isInternal = "internal", isOpen = "open"
        case likes, usersAmount
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(admin, forKey: .admin)
        try container.encode(coinPrice, forKey: .coinPrice)
        try container.encode(createdTimestamp, forKey: .createdTimestamp)
        try container.encode(diamondPrice, forKey: .diamondPrice)
        try container.encode(id, forKey: .id)
        try container.encode(isInternal, forKey: .isInternal)
        try container.encode(likes, forKey: .likes)
        try container.encode(isOpen, forKey: .isOpen)
        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
        try container.encode(usersAmount, forKey: .usersAmount)
        try? container.encode(publicId, forKey: .publicId)
        
        try super.encode(to: encoder)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        admin = try container.decode(UserPublicResponse.self, forKey: .admin)
        coinPrice = try container.decode(Int.self, forKey: .coinPrice)
        createdTimestamp = try container.decode(String.self, forKey: .createdTimestamp)
        diamondPrice = try container.decode(Int.self, forKey: .diamondPrice)
        id = try container.decode(Int.self, forKey: .id)
        isInternal = try container.decode(Bool.self, forKey: .isInternal)
        likes = try container.decode(Int.self, forKey: .likes)
        isOpen = try container.decode(Bool.self, forKey: .isOpen)
        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
        usersAmount = try container.decode(Int.self, forKey: .usersAmount)
        publicId = try? container.decode(String.self, forKey: .publicId)
        
        try super.init(from: decoder)
    }
    
}
