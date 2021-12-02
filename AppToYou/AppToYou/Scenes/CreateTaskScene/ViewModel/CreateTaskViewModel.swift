import Foundation
import XCoordinator



protocol SimpleCreateTaskViewModelDelegate: AnyObject {
    func updateA()
}

class SimpleCreateTaskViewModel {
    
//    private let router: UnownedRouter<TasksRoute>
    private let taskType: ATYTaskType
    private var taskModel: ATYUserTask!
    
    private weak var delegate: SimpleCreateTaskViewModelDelegate?
    
    private var flag = false
    
    init(delegate: SimpleCreateTaskViewModelDelegate, taskType: ATYTaskType) {
        self.taskType = taskType
        self.delegate = delegate
//        self.router = router
    }
    
    func getModel() -> [AnyObject] {
        let name = CreateTaskNameCellModel { name in
            print(name)
        }
        
        let counting = CreateTaskCountingCellModel { freq in
            switch freq {
            case .ONCE:
                self.flag.toggle()
                break
            case .EVERYDAY:
                break
            case .WEEKDAYS:
                break
            case .MONTHLY:
                break
            case .YEARLY:
                break
            case .CERTAIN_DAYS:
                break
            }
            //
        }
        
        let period = CreateTaskPeriodCalendarCellModel(startPicked: { start in
            //
        }, endPicked: { end in
            //
        })
        
        let notification = CreateNotificationAboutTaskCellModel(callback: {
            //
        }, plusCallback: {
            //
        })

        let sanction = CreateSanctionTaskCellModel(callbackText: { text in
            //
        }, questionCallback: {
            //
        })
        
        let save = SaveTaskCellModel {
            self.delegate?.updateA()
        }
        
        if flag {
            return [name, counting, period, sanction, save]
        } else {
            return [name, counting, period, notification, sanction, save]
        }
        
    }
}

protocol CreateTaskViewModelInput {
    func updateTaskCreationModel()
}

protocol CreateTaskViewModelOutput {
//    func getModel() -> [AnyObject]
    var data: Observable<[AnyObject]> { get }
}



protocol CreateTaskViewModel {
    var input: CreateTaskViewModelInput { get }
    var output: CreateTaskViewModelOutput { get }
}

extension CreateTaskViewModel where Self: CreateTaskViewModelInput & CreateTaskViewModelOutput {
    var input: CreateTaskViewModelInput { return self }
    var output: CreateTaskViewModelOutput { return self }
}


class CreateTaskViewModelImpl: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {

    private let router: UnownedRouter<TasksRoute>
    private let taskType: ATYTaskType
    
    private var taskModel: ATYUserTask!
    
    private let constructor: Tester
    
    var data: Observable<[AnyObject]> = Observable([])

    init(taskType: ATYTaskType, router: UnownedRouter<TasksRoute>) {
        self.taskType = taskType
        self.router = router
        self.constructor = Tester(type: self.taskType)
        self.constructor.delegate = self
        update()
    }
    
    func updateTaskCreationModel() {
        
    }
    
//    func getModel() -> [AnyObject] {
//        let model = constructor.construct()
//        return model.prepare()
//    }
    
}

extension CreateTaskViewModelImpl: TesterDelegate {
    func update() {
        data.value = constructor.getModel()
    }
    
}


class TaskCreationBuilder {
    
    private var taskCellModel: [AnyObject]
    
    init(taskCellModel: [AnyObject] = []) {
        self.taskCellModel = taskCellModel
    }
    
    func createTaskNameCellModel(_ completion: @escaping (String) -> Void) -> Self {
        let model = CreateTaskNameCellModel(nameCallback: completion)
        taskCellModel.append(model)
        
        return self
    }
    
    func createTaskCountingCellModel(_ completion: @escaping (ATYFrequencyTypeEnum) -> Void) -> Self {
        let model = CreateTaskCountingCellModel(frequencyPicked: completion)
        taskCellModel.append(model)
        
        return self
    }
    
    
    func createTaskPeriodCalendarCellModel(_ startCompletion: @escaping DateCompletion, _ endCompletion: @escaping DateCompletion) -> Self {
        let model = CreateTaskPeriodCalendarCellModel(startPicked: startCompletion, endPicked: endCompletion)
        taskCellModel.append(model)
        
        return self
    }
}

class TaskCretionFactory {
    
    private let builder: TaskCreationBuilder
    
    private var taskModel: ATYTaskType!
    
    init() {
        builder = TaskCreationBuilder()
    }
    
    func createTaskCreationModel(with type: ATYTaskType) {
        switch type {
        case .CHECKBOX:
            builder
                .createTaskNameCellModel { name in
                    //
                }
        case .TEXT:
            break
        case .TIMER:
            break
        case .RITUAL:
            break
        }
    }
}


enum TaskCreationCell {
    case createTaskNameCell
    case createTaskCountingCell
    case createTaskPeriodCaledarCell
    case createNotificationAboutTaskCell
    case createSanctionTaskCell
    case saveTaskCell
    
    case createCountRepeatTaskCell
    
    case createDurationTaskCell

    case createDescriptionTaskCell
    case createMaxSymbolsCountCell

}

class CreateTaskCellFactory {
    func cell(_ cell: TaskCreationCell) -> UITableViewCell {
        return .init()
    }
    
    func model(for cell: TaskCreationCell) -> AnyObject {
        return UITableViewCell()
    }
    
}

struct CheckBoxTaskModel {
    
    
    init() {
        
    }
    
}
