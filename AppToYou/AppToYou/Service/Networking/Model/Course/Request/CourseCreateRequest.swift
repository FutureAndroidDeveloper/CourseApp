import Foundation

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


struct CourseCreateRequest: Codable {
    var name: String
    var description: String
    var courseCategory1: ATYCourseCategory
    var courseCategory2: ATYCourseCategory
    var courseCategory3: ATYCourseCategory
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
        
        courseCategory1 = categories.first ?? .BEAUTY
        courseCategory2 = categories.first ?? .BEAUTY
        courseCategory3 = categories.first ?? .BEAUTY
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
    
}
