import Foundation


class TaskSanctionModel: ValidatableModel {
    let fieldModel: NaturalNumberFieldModel
    private(set) var minValue: Int
    private(set) var isEnabled: Bool
    private(set) var style: FieldStyle = StyleManager.standartTextField
    private(set) var showsMinLabel: Bool = false
    
    let questionCallback: () -> Void
    let switchChanged: (Bool) -> Void
    var errorNotification: ((CommonValidationError.Sanction?) -> Void)?
    

    init(fieldModel: NaturalNumberFieldModel, isEnabled: Bool, minValue: Int,
         switchChanged: @escaping (Bool) -> Void, questionCallback: @escaping () -> Void) {
        
        self.fieldModel = fieldModel
        self.isEnabled = isEnabled
        self.questionCallback = questionCallback
        self.switchChanged = switchChanged
        self.minValue = minValue
    }

    func setIsEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
    func updateMinValue(_ value: Int) {
        self.minValue = value
    }
    
    func showMinLabel() {
        showsMinLabel = true
    }
    
    func updateStyle(_ style: FieldStyle) {
        self.style = style
    }
    
}
