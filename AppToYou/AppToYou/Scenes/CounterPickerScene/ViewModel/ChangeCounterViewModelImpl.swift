import Foundation
import XCoordinator


class ChangeCounterViewModelImpl: ChangeCounterViewModel, ChangeCounterViewModelInput, ChangeCounterViewModelOutput {
    private struct Constants {
        static let minValue = 0
        static let maxValue = 999
    }

    private let router: UnownedRouter<CountPickerRoute>
    private let task: Task
    private let result: RealmTaskResult
    private let changeType: CountChange
    private let database: Database = RealmDatabase()

    init(task: Task, result: RealmTaskResult, changeType: CountChange, router: UnownedRouter<CountPickerRoute>) {
        self.task = task
        self.result = result
        self.changeType = changeType
        self.router = router
    }
    
    func countPicked(_ count: Int) {
        let aimValue = Int(task.taskAttribute ?? "\(Constants.minValue)") ?? Constants.minValue
        let currentValue = Int(result.result ?? "\(Constants.minValue)") ?? Constants.minValue
        var newValue: Int
        var isCompleted = false
        
        switch changeType {
        case .set:
            newValue = count
        case .add:
            newValue = min(currentValue + count, Constants.maxValue)
        case .substract:
            newValue = max(currentValue - count, Constants.minValue)
        }
        
        if newValue >= aimValue {
            isCompleted = true
        }
        database.update(result: result, value: "\(newValue)", isCompleted: isCompleted)
        
        if isCompleted && result.progress != .done {
            database.update(result: result, progress: .done)
        }
        
        router.trigger(.countPicked)
    }
    
}
