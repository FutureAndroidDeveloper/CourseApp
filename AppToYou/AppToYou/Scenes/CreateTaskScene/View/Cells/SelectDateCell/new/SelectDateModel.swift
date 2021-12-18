import Foundation


class SelectDateModel: NSCopying {
    let date: DateFieldModel
    
    init(date: DateFieldModel) {
        self.date = date
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = SelectDateModel(date: date)
        return model
    }
    
}
