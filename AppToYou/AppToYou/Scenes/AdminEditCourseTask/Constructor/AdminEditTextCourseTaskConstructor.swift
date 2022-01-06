import Foundation



class AdminEditTextCourseTaskConstructor: AdminEditCourseTaskConstructor {
    
    private(set) var textCourseTaskModel: AdminEditTextCourseTaskModel
    private(set) var baseConstructor: TextTaskConstructor
    
    
    init(mode: CreateTaskMode, model: AdminEditTextCourseTaskModel) {
        self.textCourseTaskModel = model
        self.baseConstructor = TextTaskConstructor(mode: mode, model: model.textModel)
        
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
