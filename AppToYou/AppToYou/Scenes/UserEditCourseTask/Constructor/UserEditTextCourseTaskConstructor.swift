import Foundation


class UserEditTextCourseTaskConstructor: UserEditCourseTaskConstructor {
    
    let userEditTextTaskModel: UserEditTextCourseTaskModel
    private weak var dataSource: TextTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: UserEditTextCourseTaskModel) {
        self.userEditTextTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    override func construct() {
        super.construct()
        
        guard let dataSource = dataSource else {
            return
        }
        addDescription(dataSource)
        addLimit(dataSource)
    }
    
    func setTextDataSource(dataSource: TextTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    private func addDescription(_ dataProvider: TextTaskDataSource) {
        let descriptionModel = dataProvider.getDescriptionModel()
        userEditTextTaskModel.textModel.addDescriptionHandler(model: descriptionModel)
    }
    
    private func addLimit(_ dataProvider: TextTaskDataSource) {
        let (limitModel, lock) = dataProvider.getMinSymbolsModel()
        let isLocked = lock?.isLocked ?? false
        
        userEditTextTaskModel.textModel.addLimitHandler(model: limitModel, lockModel: nil)
        userEditTextTaskModel.textModel.lengthLimitModel.updateActiveState(isLocked)
    }
}
