import Foundation


class AdminEditTimerCourseTaskConstructor: AdminEditCourseTaskConstructor {
    
    private(set) var timerCourseTaskModel: AdminEditTimerCourseTaskModel
    private(set) var baseConstructor: TimerTaskConstructor
    
    
    init(mode: CreateTaskMode, model: AdminEditTimerCourseTaskModel) {
        self.timerCourseTaskModel = model
        self.baseConstructor = TimerTaskConstructor(mode: mode, model: model.timerModel)
        
        super.init(mode: mode, model: model)
    }
    
    override func setDataSource(dataSource: AdminEditCourseTaskDataSourse?) {
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
