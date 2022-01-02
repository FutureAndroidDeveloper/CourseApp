import Foundation


class CreateRepeatCourseTaskConstructor: CreateCourseTaskConstructor {
    
    private(set) var repeatCourseTaskModel: CreateRepeatCourseTaskModel
    private(set) var baseConstructor: RepeatTaskConstructor
    
    
    init(mode: CreateTaskMode, model: CreateRepeatCourseTaskModel) {
        self.repeatCourseTaskModel = model
        self.baseConstructor = RepeatTaskConstructor(mode: mode, model: model.repeatModel)
        
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: CounterTaskDataSource?) {
        baseConstructor.setDataSource(dataSource: dataSource)
    }
    
    override func setDataSource(dataSource: CreateCourseTaskDataSourse?) {
        super.setDataSource(dataSource: dataSource)
    }
    
    override func setDelegate(delegate: CreatorDelegate?) {
        super.setDelegate(delegate: delegate)
        baseConstructor.setDelegate(delegate: delegate)
    }

    override func construct() {
        super.construct()
        baseConstructor.construct()
    }
    
}
