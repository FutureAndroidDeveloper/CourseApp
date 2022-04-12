import Foundation


class CourseUpdateRequest: CourseCreateRequest {
    var id: Int?
    var open: Bool?
    var publicId: String?
    
    init(createCourseRequest: CourseCreateRequest, id: Int? = nil, open: Bool? = nil, publicId: String? = nil) {
        let course = createCourseRequest
        self.id = id
        self.open = open
        self.publicId = publicId
        super.init(
            name: course.name, description: course.description,
            courseCategory1: course.courseCategory1, courseCategory2: course.courseCategory2,
            courseCategory3: course.courseCategory3, courseType: course.courseType,
            durationType: course.durationType, privacyEnabled: course.privacyEnabled,
            picPath: course.picPath, price: course.price, duration: course.duration,
            chatPath: course.chatPath
        )
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case open
        case publicId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        open = try? container.decode(Bool.self, forKey: .open)
        publicId = try? container.decode(String.self, forKey: .publicId)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(id, forKey: .id)
        try? container.encode(open, forKey: .open)
        try? container.encode(publicId, forKey: .publicId)
        try super.encode(to: encoder)
    }
}
