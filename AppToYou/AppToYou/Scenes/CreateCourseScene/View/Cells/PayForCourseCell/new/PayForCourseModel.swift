import Foundation


class PayForCourseModel: NSCopying {
    let model: NaturalNumberFieldModel

    init(model: NaturalNumberFieldModel) {
        self.model = model
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let newModel = PayForCourseModel(model: model)
        return newModel
    }
}
