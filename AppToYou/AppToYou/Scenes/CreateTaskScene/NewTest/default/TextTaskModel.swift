import Foundation


protocol TextTaskCreationDelegate: DefaultTaskCreationDelegate {
    func getDescriptionModel() -> PlaceholderTextViewModel
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?)
}


class TextTaskModel<DataProvider>: DefaultTaskModel<TextCreateTaskModel, DataProvider> where DataProvider: TextTaskCreationDelegate {

    override func construct() {
        super.construct()

        guard let dataProvider = delegate else {
            return
        }
        addDescription(dataProvider)
        addLimit(dataProvider)
        
        if mode == .editCourseTask {
            model.descriptionModel.isEditable = false
        }
    }
    
    private func addDescription(_ dataProvider: TextTaskCreationDelegate) {
        let descriptionModel = dataProvider.getDescriptionModel()
        model.addDescriptionHandler(model: descriptionModel)
    }
    
    private func addLimit(_ dataProvider: TextTaskCreationDelegate) {
        let (limitModel, lockModel) = dataProvider.getMinSymbolsModel()
        model.addLimitHandler(model: limitModel, lockModel: lockModel)
    }
    
}
