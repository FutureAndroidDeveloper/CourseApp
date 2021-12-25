import Foundation


class SelectDateModel: NSCopying, ValidatableModel {
    
    let date: DateFieldModel
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    
    init(date: DateFieldModel) {
        self.date = date
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = SelectDateModel(date: date)
        return model
    }
    
}
