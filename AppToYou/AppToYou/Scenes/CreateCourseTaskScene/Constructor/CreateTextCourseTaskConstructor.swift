import Foundation


class CreateTextCourseTaskConstructor: CreateCourseTaskConstructor {
    
    private(set) var textCourseTaskModel: CreateTextCourseTaskModel
    private(set) var baseConstructor: TextTaskConstructor
    
    
    init(mode: CreateTaskMode, model: CreateTextCourseTaskModel) {
        self.textCourseTaskModel = model
        self.baseConstructor = TextTaskConstructor(mode: mode, model: model.textModel)
        
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: TextTaskDataSource?) {
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
