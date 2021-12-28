//
//  ATYCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 13.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

struct ATYCourse {
    var tsCreated: String? = Date().toString(dateFormat: .simpleDateFormat)
    var tsUpdated: String? = Date().toString(dateFormat: .simpleDateFormat)
    var coinPrice : Int?
    var diamondPrice : Int?
    var courseCategory : [ATYCourseCategory] = []
    var duration : ATYDurationCourse = .init(year: 0, month: 0, day: 0)
    var limited : ATYDurationType = .LIMITED
    var isInternal: Bool = false
    var isOpen: Bool = false
    var courseType: ATYCourseType = .PUBLIC
    var privacyEnabled: Bool = false
    var publicId: String?
    var chatPath : String?
    var courseDescription: String?
    var likes : Int?
    var courseName : String = ""
    var picPath: String?
    var usersAmount : Int? = 1
    var adminFk : Int? = 0

    var isMyCourse: Bool = true
}

// enums

struct ATYDurationCourse {
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
}

enum ATYCourseCategory: String, CaseIterable, Codable {
    case EMPTY
    case HEALTHY_LIFESTYLE
    case CHILDREN
    case PETS
    case FOOD
    case FOREIGN_LANGUAGES
    case BEAUTY
    case EDUCATION
    case PERSONAL_DEVELOPMENT
    case CREATION
    case FINANCE
    case HOBBY
    case IT
    case OTHER
    case RELATIONSHIPS
    
    var title : String? {
        switch self {
        case . EMPTY:
            return nil
        case .HEALTHY_LIFESTYLE:
            return "ЗОЖ"
        case .CHILDREN:
            return "Дети"
        case .PETS:
            return "Домашние животные"
        case .FOOD:
            return "Еда"
        case .FOREIGN_LANGUAGES:
            return "Иностранные языки"
        case .BEAUTY:
            return "Красота"
        case .EDUCATION:
            return "Образование"
        case .PERSONAL_DEVELOPMENT:
            return "Развитие личности"
        case .CREATION:
            return "Творчество"
        case .FINANCE:
            return "Финансы"
        case .HOBBY:
            return "Хобби"
        case .IT:
            return "IT"
        case .OTHER:
            return "Другое"
        case .RELATIONSHIPS:
            return "Отношения"
        }
    }
}

enum ATYDurationType {
    case LIMITED
    case UNLIMITED
}

enum ATYCourseType: String, Codable {
    case PUBLIC
    case PRIVATE
    case PAID
    
    var title: String? {
        switch self {
        case .PUBLIC:
            return "Открытый"
        case .PRIVATE:
            return  "Закрытый"
        case .PAID:
            return "Платный"
        }
    }
    
    var description: String {
        switch self {
        case .PUBLIC:
            return "Любой пользователь приложения может стать участником курса, выполнять его задачи и писать в общем чате"
        case .PRIVATE:
            return "Лишь после одобрения заявки администратором курса, пользователь может стать его участником "
        case .PAID:
            return "Лишь после оплаты курса, пользователь может стать его участником "
        }
    }
    
}
