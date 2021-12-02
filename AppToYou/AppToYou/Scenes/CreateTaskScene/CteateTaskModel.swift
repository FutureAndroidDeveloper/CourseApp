//
//  CteateTaskModel.swift
//  AppToYou
//
//  Created by mac on 1.12.21.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

//protocol CteateTaskModel {
//    var nameModel: CreateTaskNameCellModel { get }
//    var frequencyModel: CreateTaskCountingCellModel { get }
//    var periodModel: CreateTaskPeriodCalendarCellModel? { get }
//    var notificationModel: CreateNotificationAboutTaskCellModel { get }
//    var sanctionModel: CreateSanctionTaskCellModel { get }
//    var saveModel: SaveTaskCellModel { get }
//}

protocol TesterDelegate: AnyObject {
    func update()
}

class Tester {
    
    private var task: ATYUserTask
    private var type: ATYTaskType
    
    weak var delegate: TesterDelegate?
    
    private var model: CreateTaskModel?
    
    init(type: ATYTaskType) {
        self.type = type
        self.task = ATYUserTask()
        task.taskType = type
        construct()
    }
    
    private func construct() {
        
        switch type {
        case .CHECKBOX:
            model = CreateTaskModel()
        case .TEXT:
            let textModel = TextCreateTaskModel()
            textModel.addDescriptionHandler { description in
                self.task.taskDescription = description
            }
            textModel.addLimitHandler()
            
            model = textModel
        case .TIMER:
            let timerModel = TimerCreateTaskModel()
            timerModel.addDurationHandler()
            
            model = timerModel
        case .RITUAL:
            let repeatModel = RepeatCreateTaskModel()
            repeatModel.addCountHandler()
            
            model = repeatModel
        }
        
        model?.addNameHandler { name in
            print(name)
            self.task.taskName = name
        }
        
        model?.addFrequencyHandler { frequency in
            print(frequency)
            if frequency == .ONCE {
                self.model?.removePeriodHandler()
                self.delegate?.update()
            } else {
                self.addPeriod()
                self.delegate?.update()
            }
            self.task.frequencyType = frequency
        }
        
        model?.addPeriodHandler(startPicked: { start in
            print(start)
            self.task.startDate = start ?? "N/A"
        }, endPicked: { end in
            print(end)
            self.task.endDate = end ?? "N/A"
        })
        
        model?.addNotificationHandler(callback: {
            print("Add Notification handler")
        }, plusCallback: {
            print("Add plus notification handler")
        })
        
        model?.addSanctionHandler(callbackText: { sanction in
            print(sanction)
            self.task.taskSanction = Int(sanction) ?? -1
        }, questionCallback: {
            print("Question Handler")
        })
        
        model?.addSaveHandler {
            print("Save")
            self.delegate?.update()
            // validate + после валидации при необходимости обновить модель ячеек с указанием ошибок
            // при успешной валидации отправить запрос на сервер
            // при успешном выполнении запроса, сохранить в бд
        }
    }
    
    private func addPeriod() {
        model?.addPeriodHandler(startPicked: { start in
            print(start)
            self.task.startDate = start ?? "N/A"
        }, endPicked: { end in
            print(end)
            self.task.endDate = end ?? "N/A"
        })
    }
    
    func getModel() -> [AnyObject] {        
        return model?.prepare() ?? []
    }
    
}

class CreateTaskModel {
    var nameModel: CreateTaskNameCellModel!
    var frequencyModel: CreateTaskCountingCellModel!
    var periodModel: CreateTaskPeriodCalendarCellModel?
    var notificationModel: CreateNotificationAboutTaskCellModel!
    var sanctionModel: CreateSanctionTaskCellModel!
    var saveModel: SaveTaskCellModel!
    
    func addNameHandler(_ handler: @escaping (String) -> Void) {
        nameModel = CreateTaskNameCellModel(nameCallback: handler)
    }
    
    func addFrequencyHandler(_ handler: @escaping (ATYFrequencyTypeEnum) -> Void) {
        frequencyModel = CreateTaskCountingCellModel(frequencyPicked: handler)
    }
    
    func addPeriodHandler(startPicked: @escaping DateCompletion, endPicked: @escaping DateCompletion) {
        periodModel = CreateTaskPeriodCalendarCellModel(startPicked: startPicked, endPicked: endPicked)
    }
    
    func removePeriodHandler() {
        periodModel = nil
    }
    
    func addNotificationHandler(callback: @escaping () -> Void, plusCallback: @escaping () -> Void) {
        notificationModel = CreateNotificationAboutTaskCellModel(callback: callback, plusCallback: plusCallback)
    }
    
    func addSanctionHandler(callbackText: @escaping (String) -> Void, questionCallback: @escaping () -> Void) {
        sanctionModel = CreateSanctionTaskCellModel(callbackText: callbackText, questionCallback: questionCallback)
    }
    
    func addSaveHandler(_ handler: @escaping () -> Void) {
        saveModel = SaveTaskCellModel(callback: handler)
    }
    
    func prepare() -> [AnyObject] {
        var result: [AnyObject] = [nameModel]
        let tail: [AnyObject?] = [frequencyModel, periodModel, notificationModel, sanctionModel, saveModel]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result
    }
    
    func getAdditionalModels() -> [AnyObject] {
        return []
    }
}


class RepeatCreateTaskModel: CreateTaskModel {
    var countModel: CreateCountRepeatTaskCellModel!
    
    func addCountHandler() {
        countModel = CreateCountRepeatTaskCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}


class TimerCreateTaskModel: CreateTaskModel {
    var durationModel: CreateDurationTaskCellModel!
    
    func addDurationHandler() {
        durationModel = CreateDurationTaskCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [durationModel]
    }
}


class TextCreateTaskModel: CreateTaskModel {
    var descriptionModel: CreateDescriptionTaskCellModel!
    var lengthLimitModel: CreateMaxCountSymbolsCellModel!
    
    func addDescriptionHandler(_ handler: @escaping (String) -> Void) {
        descriptionModel = CreateDescriptionTaskCellModel(descriptionEntered: handler)
    }
    
    func addLimitHandler() {
        lengthLimitModel = CreateMaxCountSymbolsCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
