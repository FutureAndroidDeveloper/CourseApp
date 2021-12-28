import Foundation


/**
 Контейнер типов: Заполняемый контент таблицы - его модель.
 */
class TableTypesHolder {
    
    let inflatableType: InflatableView.Type
    let modelType: AnyObject.Type
    
    init(inflatableType: InflatableView.Type, modelType: AnyObject.Type) {
        self.inflatableType = inflatableType
        self.modelType = modelType
    }
    
    func isModelEquals<Model: AnyObject>(model: Model) -> Bool {
        return modelType == type(of: model)
    }
    
}
