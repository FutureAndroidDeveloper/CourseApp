import Foundation


class AdminEditRepeatCourseTaskConstructor: AdminEditCourseTaskConstructor {
    
    private(set) var repeatCourseTaskModel: AdminEditRepeatCourseTaskModel
    private(set) var baseConstructor: RepeatTaskConstructor
    
    
    init(mode: CreateTaskMode, model: AdminEditRepeatCourseTaskModel) {
        self.repeatCourseTaskModel = model
        self.baseConstructor = RepeatTaskConstructor(mode: mode, model: model.repeatModel)
        
        super.init(mode: mode, model: model)
    }
    
    override func setDataSource(dataSource: AdminEditCourseTaskDataSource?) {
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
