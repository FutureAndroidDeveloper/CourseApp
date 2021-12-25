import Foundation
import UIKit


class FieldFactory {
    
    private struct Constants {
        static let fieldHeight: CGFloat = 44
    }
    
    static let shared = FieldFactory()
    
    private init() {
        
    }
    
    func getTextField() -> TextField {
        let field = TextField(style: StyleManager.standartTextField)
        setHeight(for: field, height: Constants.fieldHeight)
        return field
    }
    
    func getNaturalNumberField() -> NaturalNumberTextField {
        let field = NaturalNumberTextField(style: StyleManager.standartTextField)
        setHeight(for: field, height: Constants.fieldHeight)
        return field
    }
    
    func getDateField(style: SelectDateFieldStyle) -> DateTextField {
        var fieldStyle: FieldStyle
        
        switch style {
        case .standart:
            fieldStyle = StyleManager.standartTextField
        case .highlighted:
            fieldStyle = StyleManager.highlightedTextField
        }
        
        let field = DateTextField(style: fieldStyle)
        setHeight(for: field, height: Constants.fieldHeight)
        return field
    }
    
    func setHeight(for field: UIView, height: CGFloat) {
        field.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
