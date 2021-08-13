//
//  ATYAchievementType.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

enum ATYAchievementType : Int, CaseIterable{
    case marafonec
    case manyak
    case boec
    case bestFriend
    case maksimalist
    case nepobedimiy
    case psix
    case novichek
    case adept
    case kouch

    var achievementName: String {
        switch self {
        case .marafonec:
            return "Марафонец"
        case .manyak:
            return "Маньяк"
        case .boec:
            return "Боец"
        case .bestFriend:
            return "Лучший друг"
        case .maksimalist:
            return "Максималист"
        case .nepobedimiy:
            return "Непобедимый"
        case .psix:
            return "Псих"
        case .novichek:
            return "Новичок"
        case .adept:
            return "Адепт"
        case .kouch:
            return "Коуч"
        }
    }

    var achievementDescription: String {
        switch self {
        case .marafonec:
            return "Выполнять все задания 60 дней подряд"
        case .manyak:
            return "Потратить на оплату штрафов 10 000 монет"
        case .boec:
            return "Полностью выполнить все задания курса"
        case .bestFriend:
            return "Пригласить на курс 5 друзей"
        case .maksimalist:
            return "Выполнить за день более 20 задач"
        case .nepobedimiy:
            return "Выполнять задачи 100 дней подряд"
        case .psix:
            return "Потратить на оплату штрафов 10 000 монет"
        case .novichek:
            return "Пройти один курс"
        case .adept:
            return "Пройти 4 курса"
        case .kouch:
            return "Создать свой курс"
        }
    }

    var achievementImage : UIImage? {
        switch self {
        case .marafonec:
            return R.image.maniakImage()
        case .manyak:
            return R.image.maniakImage()
        case .boec:
            return R.image.maniakImage()
        case .bestFriend:
            return R.image.maniakImage()
        case .maksimalist:
            return R.image.maniakImage()
        case .nepobedimiy:
            return R.image.maniakImage()
        case .psix:
            return R.image.maniakImage()
        case .novichek:
            return R.image.maniakImage()
        case .adept:
            return R.image.maniakImage()
        case .kouch:
            return R.image.maniakImage()
        }
    }

    var moneyForAchievement : Int {
        switch self {
        case .marafonec:
            return 50
        case .manyak:
            return 50
        case .boec:
            return 60
        case .bestFriend:
            return 150
        case .maksimalist:
            return 80
        case .nepobedimiy:
            return 80
        case .psix:
            return 180
        case .novichek:
            return 10
        case .adept:
            return 100
        case .kouch:
            return 100
        }
    }

    var progressAchievement : Double {
        switch self {
        case .marafonec:
            return 0.2
        case .manyak:
            return 0.3
        case .boec:
            return 1.0
        case .bestFriend:
            return 0.6
        case .maksimalist:
            return 0.7
        case .nepobedimiy:
            return 0.1
        case .psix:
            return 1.0
        case .novichek:
            return 0
        case .adept:
            return 0.3
        case .kouch:
            return 0.9
        }
    }
}
