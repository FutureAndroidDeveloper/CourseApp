import Foundation

protocol CounterTaskDataSource: CheckboxTaskDataSource {
    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?)
}


class RepeatTaskConstructor: CheckboxTaskConstructor {
    
    let repeatModel: RepeatCreateTaskModel
    private weak var dataSource: CounterTaskDataSource?
    
    init(mode: CreateTaskMode, model: RepeatCreateTaskModel) {
        self.repeatModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: CounterTaskDataSource?) {
        super.setDataSource(dataSource: dataSource)
        self.dataSource = dataSource
    }

    override func construct() {
        super.construct()
        guard let dataSource = dataSource else {
            return
        }
        addCounter(dataSource)
    }
    
    private func addCounter(_ dataProvider: CounterTaskDataSource) {
        let (counterModel, lockModel) = dataProvider.getCounterModel()
        repeatModel.addCounter(model: counterModel, lockModel: lockModel)
    }
    
}
