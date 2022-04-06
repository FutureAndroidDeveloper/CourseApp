import Foundation



class UserEditCourseTaskConstructor: CheckboxTaskConstructor {
    
    let userEditTaskModel: UserEditCourseTaskModel
    private weak var dataSource: EditCourseTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: UserEditCourseTaskModel) {
        self.userEditTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    override func construct() {
        super.construct()
        guard let dataSource = dataSource else {
            return
        }
        addCourseNameModel(dataSource)
    }
    
    func setConstructorDataSource(dataSource: EditCourseTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    override func setEnableStateForFields() {
        checkboxModel.weekdayModel?.updateActiveState(false)
        checkboxModel.nameModel.updateActiveState(false)
        checkboxModel.periodModel?.updateActiveState(false)
    }
    
    private func addCourseNameModel(_ dataProvider: EditCourseTaskDataSource) {
        let name = dataProvider.getCourseName()
        userEditTaskModel.addCourseNameModel(name: name)
    }
    
}
