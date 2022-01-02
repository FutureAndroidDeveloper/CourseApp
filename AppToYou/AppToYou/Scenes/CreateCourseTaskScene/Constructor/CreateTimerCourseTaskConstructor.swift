import Foundation


class CreateTimerCourseTaskConstructor: CreateCourseTaskConstructor {
    
    private(set) var timerCourseTaskModel: CreateTimerCourseTaskModel
    private(set) var baseConstructor: TimerTaskConstructor
    
    
    init(mode: CreateTaskMode, model: CreateTimerCourseTaskModel) {
        self.timerCourseTaskModel = model
        self.baseConstructor = TimerTaskConstructor(mode: mode, model: timerCourseTaskModel.timerModel)
        
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: TimerTaskDataSource?) {
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
