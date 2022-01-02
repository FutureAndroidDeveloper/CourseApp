import Foundation


//protocol TextTaskCreationDelegate: DefaultTaskCreationDelegate {
//    func getDescriptionModel() -> PlaceholderTextViewModel
//    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?)
//}


protocol TextTaskDataSource: CheckboxTaskDataSource {
    func getDescriptionModel() -> PlaceholderTextViewModel
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?)
}


class TextTaskConstructor: CheckboxTaskConstructor {
    
    let textModel: TextCreateTaskModel
    private weak var dataSource: TextTaskDataSource?
    
    init(mode: CreateTaskMode, model: TextCreateTaskModel) {
        self.textModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: TextTaskDataSource?) {
        super.setDataSource(dataSource: dataSource)
        self.dataSource = dataSource
    }

    override func construct() {
        super.construct()

        guard let dataSource = dataSource else {
            return
        }
        addDescription(dataSource)
        addLimit(dataSource)
        
//        if case .editCourseTask = mode {
//            model.descriptionModel.isEditable = false
//        }
    }
    
    private func addDescription(_ dataProvider: TextTaskDataSource) {
        let descriptionModel = dataProvider.getDescriptionModel()
        textModel.addDescriptionHandler(model: descriptionModel)
    }
    
    private func addLimit(_ dataProvider: TextTaskDataSource) {
        let (limitModel, lockModel) = dataProvider.getMinSymbolsModel()
        textModel.addLimitHandler(model: limitModel, lockModel: lockModel)
    }

}


//class TextTaskModel<DataProvider>: DefaultTaskModel<TextCreateTaskModel, DataProvider> where DataProvider: TextTaskCreationDelegate {
//
//    override func construct() {
//        super.construct()
//
//        guard let dataProvider = delegate else {
//            return
//        }
//        addDescription(dataProvider)
//        addLimit(dataProvider)
//
//        if case .editCourseTask = mode {
//            model.descriptionModel.isEditable = false
//        }
//    }
//
//    private func addDescription(_ dataProvider: TextTaskCreationDelegate) {
//        let descriptionModel = dataProvider.getDescriptionModel()
//        model.addDescriptionHandler(model: descriptionModel)
//    }
//
//    private func addLimit(_ dataProvider: TextTaskCreationDelegate) {
//        let (limitModel, lockModel) = dataProvider.getMinSymbolsModel()
//        model.addLimitHandler(model: limitModel, lockModel: lockModel)
//    }
//
//}
