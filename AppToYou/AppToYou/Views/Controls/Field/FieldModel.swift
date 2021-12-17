import UIKit


/**
 Полная модель поля с дополнительным контентом.
 */
class FieldModel<Value> {
    let content: FieldContentModel<Value>
    var leftContent: FieldAdditionalContentModel?
    var rightContent: FieldAdditionalContentModel?
    
    init(content: FieldContentModel<Value>,
         leftContent: FieldAdditionalContentModel? = nil,
         rightContent: FieldAdditionalContentModel? = nil) {
        
        self.content = content
        self.leftContent = leftContent
        self.rightContent = rightContent
    }
    
}


/**
 Модель представления поля.
 */
struct FieldContentModel<Value> {
    /**
     Модель поля.
     */
    let fieldModel: BaseFieldModel<Value>
    
    /**
     Отступы поля.
     */
    let insets: UIEdgeInsets
}


/**
 Модель представления дополнительного контента поля.
 */
struct FieldAdditionalContentModel {
    /**
     Представление контента.
     */
    let contentView: UIView
    
    /**
     Отступы контента.
     */
    let insets: UIEdgeInsets
}
