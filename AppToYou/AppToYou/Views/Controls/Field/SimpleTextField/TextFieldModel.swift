import Foundation


class TextFieldModel: BaseFieldModel<String> {
    
    private struct Constants {
        static let defaultValue = String()
    }
    
    /**
      Создание модели с пустым значением и без placeholder.
     */
    convenience init() {
        self.init(value: Constants.defaultValue)
    }
    
//    /**
//      Создание модели с пустым значением.
//     */
//    convenience init(placehodler: String?) {
//        self.init(value: Constants.defaultValue, placeholder: placeholder)
//    }
    
}
