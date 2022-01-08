import UIKit


class AddCourseTaskModel {
    var titleModel: AddTaskTitleModel!
    var descriptionModel: AddTaskDescriptionModel?
    var attributeModel: AddTaskAttributeModel!
    var fieldModel: AnyObject?
    var sanctionModel: TaskSanctionModel?
    
    func addTitle(model: AddTaskTitleModel) {
        titleModel = model
    }
    
    func addDescription(_ description: String) {
        descriptionModel = AddTaskDescriptionModel(descriptionText: description)
    }
    
    func addAttribute(title: String) {
        attributeModel = AddTaskAttributeModel(title: title)
    }
    
    func addField(model: AnyObject) {
        fieldModel = model
    }
    
    func addSanction(model: NaturalNumberFieldModel, isEnabled: Bool, minValue: Int,
                     switchChanged: @escaping (Bool) -> Void, questionCallback: @escaping () -> Void) {
        
        sanctionModel = TaskSanctionModel(
            fieldModel: model, isEnabled: isEnabled, minValue: minValue,
            switchChanged: switchChanged, questionCallback: questionCallback
        )
    }
    
    func prepare() -> [AnyObject] {
        let models = [titleModel, descriptionModel, attributeModel, fieldModel, sanctionModel]
        return models.compactMap { $0 }
    }
    
}
