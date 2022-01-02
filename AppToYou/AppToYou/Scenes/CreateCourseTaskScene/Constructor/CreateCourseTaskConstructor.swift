import Foundation


protocol CreateCourseTaskDataSourse: CheckboxTaskDataSource {
    func getMinCourseSanctionModel() -> NaturalNumberFieldModel
//    func getCourseName() -> String
    func getCourseTaskDurationModel() -> (duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel)
}


class CreateCourseTaskConstructor: CheckboxTaskConstructor {
    
    let courseTaskModel: CreateCourseTaskModel
    private weak var dataSource: CreateCourseTaskDataSourse?
    
    init(mode: CreateTaskMode, model: CreateCourseTaskModel) {
        self.courseTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: CreateCourseTaskDataSourse?) {
        super.setDataSource(dataSource: dataSource)
        self.dataSource = dataSource
    }
    
    
    override func construct() {
        super.construct()
        guard let dataSource = dataSource else {
            return
        }
        
        adLockHeader()
        addMinSanctionModel(dataSource)
        addCourseTaskDuration(dataSource)
        
//        switch mode {
//        case .createUserTask, .editUserTask:
//            break
//
//        case .createCourseTask:
//            adLockHeader()
//            addMinSanctionModel(dataSource)
//
//        case .editCourseTask:
//            addCourseNameModel(dataSource)
//
//        case .adminEditCourseTask:
//            adLockHeader()
//            addCourseNameModel(dataSource)
//            addMinSanctionModel(dataSource)
//        }
    }
    
    
//    private func addCourseNameModel(_ dataProvider: CourseTaskDataSourse) {
//        let name = dataProvider.getCourseName()
//        courseTaskModel.addCourseNameModel(name: name)
//    }
    
    private func adLockHeader() {
        courseTaskModel.addLockHeaderModel()
    }
    
    private func addMinSanctionModel(_ dataProvider: CreateCourseTaskDataSourse) {
        let minSanctionModel = dataProvider.getMinCourseSanctionModel()
        courseTaskModel.addCourseMinSanction(model: minSanctionModel)
    }
    
    private func addCourseTaskDuration(_ dataProvider: CreateCourseTaskDataSourse) {
        let (durationModel, isInfinite) = dataProvider.getCourseTaskDurationModel()
        courseTaskModel.addCourseTaskDurationHandler(duration: durationModel, isInfiniteModel: isInfinite, timerCallback: { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .courseTaskDuration, delegate: nil)
            
        })
    }
    
}
