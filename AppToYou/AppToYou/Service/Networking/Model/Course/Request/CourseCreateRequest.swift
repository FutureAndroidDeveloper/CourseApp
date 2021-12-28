import Foundation


class CourseCreateRequest: Codable {
    var name: String
    var description: String
    var courseCategory1: ATYCourseCategory = .EMPTY
    var courseCategory2: ATYCourseCategory = .EMPTY
    var courseCategory3: ATYCourseCategory = .EMPTY
    var courseType: ATYCourseType
    var durationType: DurationType
    var privacyEnabled: Bool
    
    var picPath: String?
    var price: Int?
    var duration: Duration?
    var chatPath: String?
    
    init(name: String, description: String, categories: [ATYCourseCategory],
         courseType: ATYCourseType, duration: CourseDurationCellModel, privacyEnabled: Bool) {
        
        self.name = name
        self.description = description
        self.courseType = courseType
        self.privacyEnabled = privacyEnabled
        
        let durationTime = DurationTime(hour: duration.durationModel.hourModel.value,
                                        min: duration.durationModel.minModel.value,
                                        sec: duration.durationModel.secModel.value)
        
        if duration.isInfiniteModel.isSelected {
            self.durationType = .unlimited
        } else {
            self.duration = .init(duration: durationTime)
            self.durationType = .limited
        }
        
        for index in 0..<categories.count {
            switch index {
            case 0:
                courseCategory1 = categories[index]
            case 1:
                courseCategory2 = categories[index]
            case 2:
                courseCategory3 = categories[index]
            default:
                return
            }
        }
    }
    
    init(name: String, description: String, courseCategory1: ATYCourseCategory, courseCategory2: ATYCourseCategory,
         courseCategory3: ATYCourseCategory, courseType: ATYCourseType, durationType: DurationType,
         privacyEnabled: Bool, picPath: String? = nil, price: Int? = nil,
         duration: Duration? = nil, chatPath: String? = nil) {
        
        self.name = name
        self.description = description
        self.courseCategory1 = courseCategory1
        self.courseCategory2 = courseCategory2
        self.courseCategory3 = courseCategory3
        self.courseType = courseType
        self.durationType = durationType
        self.privacyEnabled = privacyEnabled
        self.picPath = picPath
        self.price = price
        self.duration = duration
        self.chatPath = chatPath
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, description, courseType
        case courseCategory1, courseCategory2, courseCategory3
        case durationType, duration
        case privacyEnabled
        case picPath, chatPath
        case price
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(courseCategory1, forKey: .courseCategory1)
        try container.encode(courseCategory2, forKey: .courseCategory2)
        try container.encode(courseCategory3, forKey: .courseCategory3)
        try container.encode(courseType, forKey: .courseType)
        try container.encode(durationType, forKey: .durationType)
        try container.encode(privacyEnabled, forKey: .privacyEnabled)
        
        try? container.encode(picPath, forKey: .picPath)
        try? container.encode(price, forKey: .price)
        try? container.encode(duration, forKey: .duration)
        try? container.encode(chatPath, forKey: .chatPath)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        courseCategory1 = try container.decode(ATYCourseCategory.self, forKey: .courseCategory1)
        courseCategory2 = try container.decode(ATYCourseCategory.self, forKey: .courseCategory2)
        courseCategory3 = try container.decode(ATYCourseCategory.self, forKey: .courseCategory3)
        courseType = try container.decode(ATYCourseType.self, forKey: .courseType)
        durationType = try container.decode(DurationType.self, forKey: .durationType)
        privacyEnabled = try container.decode(Bool.self, forKey: .privacyEnabled)
        
        
        picPath = try? container.decode(String.self, forKey: .picPath)
        price = try? container.decode(Int.self, forKey: .price)
        duration = try? container.decode(Duration.self, forKey: .duration)
        chatPath = try? container.decode(String.self, forKey: .chatPath)
    }
}


enum DurationType: String, Codable {
    case limited = "LIMITED"
    case unlimited = "UNLIMITED"
    
    var isInfinite: Bool {
        return self == .unlimited
    }
}

struct Duration: Codable {
    let day: Int
    let month: Int
    let year: Int
    
    init(duration: DurationTime) {
        self.day = Int(duration.hour) ?? 0
        self.month = Int(duration.min) ?? 0
        self.year = Int(duration.sec) ?? 0
    }
    
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
}
