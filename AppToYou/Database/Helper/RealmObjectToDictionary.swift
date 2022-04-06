import Foundation
import RealmSwift
import Realm


extension Object {
    
    /**
     Конвертирование Realm объекта в коллекцию пар ключ-значение.
     
     Обрабатывает стандартые типы, Realm объекты,  также Realm коллекции `List`.
     Для пустых Realm коллекций используется значение `null`.
     */
    func toDictionary() -> NSDictionary {
        let properties = objectSchema.properties
        let resultDictionary = NSMutableDictionary(dictionary: dictionaryWithValues(forKeys: properties.map { $0.name }))
        
        properties.forEach {
            // если значение nil
            guard let value = self.value(forKey: $0.name) else {
                return
            }
            
            // realm ID объекта
            if let objectId = value as? ObjectId {
                resultDictionary.setValue(objectId.stringValue, forKey: $0.name)
            }
            
            // realm объект
            if let entity = value as? Object {
                resultDictionary.setValue(entity.toDictionary(), forKey: $0.name)
            }
            // realm коллекция
            else if let list = (value as? RLMSwiftCollectionBase)?._rlmCollection {
                var objects: [Any] = []
                
                // для пустой коллекции установить значение `null`
                if list.count == .zero {
                    resultDictionary.setValue(NSNull(), forKey: $0.name)
                    return
                }
                
                for index in 0..<list.count {
                    let object = list.object(at: index)
                    
                    // коллекция из realm объектов
                    if let entity = object as? Object {
                        objects.append(entity.toDictionary())
                    }
                    // колекция из стандартных типов
                    else {
                        objects.append(object)
                    }
                }
                resultDictionary.setObject(objects, forKey: $0.name as NSCopying)
            }
        }
        return resultDictionary
    }
    
}
