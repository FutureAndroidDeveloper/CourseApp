import Foundation


protocol AdminEditCourseTaskDataSourse: CreateCourseTaskDataSourse {
    func getCourseName() -> String
}


class AdminEditCourseTaskConstructor: CreateCourseTaskConstructor {
    
    let adminEditTaskModel: AdminEditCourseTaskModel
    private weak var dataSource: AdminEditCourseTaskDataSourse?
    
    
    init(mode: CreateTaskMode, model: AdminEditCourseTaskModel) {
        self.adminEditTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: AdminEditCourseTaskDataSourse?) {
        super.setDataSource(dataSource: dataSource)
        self.dataSource = dataSource
    }
    
    override func construct() {
        super.construct()
        guard let dataSource = dataSource else {
            return
        }
        addCourseNameModel(dataSource)
    }
    
    private func addCourseNameModel(_ dataProvider: AdminEditCourseTaskDataSourse) {
        let name = dataProvider.getCourseName()
        adminEditTaskModel.addCourseNameModel(name: name)
    }
}
