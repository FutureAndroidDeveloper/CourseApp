import Foundation


class TaskSanctionModel: ValidatableModel {
    let fieldModel: NaturalNumberFieldModel
    private(set) var isEnabled: Bool
    let questionCallback: () -> Void
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    

    init(fieldModel: NaturalNumberFieldModel, isEnabled: Bool, questionCallback: @escaping () -> Void) {
        self.fieldModel = fieldModel
        self.isEnabled = isEnabled
        self.questionCallback = questionCallback
    }

    func setIsEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
}
