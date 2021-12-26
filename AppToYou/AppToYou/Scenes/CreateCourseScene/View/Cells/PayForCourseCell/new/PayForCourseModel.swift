import Foundation


class PayForCourseModel: NSCopying, ValidatableModel {
    
    let model: NaturalNumberFieldModel
    var errorNotification: ((CourseError?) -> Void)?

    init(model: NaturalNumberFieldModel) {
        self.model = model
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let newModel = PayForCourseModel(model: model)
        return newModel
    }
    
}
