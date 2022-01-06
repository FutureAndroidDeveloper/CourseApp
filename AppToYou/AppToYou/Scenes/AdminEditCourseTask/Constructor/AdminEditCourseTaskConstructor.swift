import Foundation


class AdminEditCourseTaskConstructor: CreateCourseTaskConstructor {
    
    let adminEditTaskModel: AdminEditCourseTaskModel
    private weak var dataSource: AdminEditCourseTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: AdminEditCourseTaskModel) {
        self.adminEditTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: AdminEditCourseTaskDataSource?) {
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
    
    private func addCourseNameModel(_ dataProvider: EditCourseTaskDataSource) {
        let name = dataProvider.getCourseName()
        adminEditTaskModel.addCourseNameModel(name: name)
    }
}
