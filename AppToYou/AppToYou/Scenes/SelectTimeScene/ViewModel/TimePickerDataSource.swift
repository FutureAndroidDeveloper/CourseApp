import UIKit


class TimePickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var firstComponentValue: Int = 0
    private var secondComponentValue: Int = 0
    private var thirdComponentValue: Int = 0
    
    var taskDuration: DurationTime {
        return DurationTime(hour: "\(firstComponentValue)",
                            min: "\(secondComponentValue)",
                            sec: "\(thirdComponentValue)")
    }
    
    var courseDuration: Duration {
        return Duration(day: thirdComponentValue, month: secondComponentValue, year: firstComponentValue)
    }
    
    private let type: TimePickerType
    
    init(type: TimePickerType) {
        self.type = type
        super.init()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type.components
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.getNumberOfRows(for: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: firstComponentValue = row
        case 1: secondComponentValue = row
        case 2: thirdComponentValue = row
        default: break
        }
    }
    
}
