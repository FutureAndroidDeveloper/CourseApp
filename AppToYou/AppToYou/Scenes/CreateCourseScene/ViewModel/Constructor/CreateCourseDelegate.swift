import Foundation


protocol CreateCourseDelegate: CreateCourseDataSource {
    /**
     Обновить структуру создания курса.
     
     Вызывается после добавления/удаления полей.
     */
    func updateStructure()
    
    /**
     Обновить значения в полях создания курса.
     */
    func updateValue()
    
    func showTimePicker(pickerType: TimePickerType)
    func showPhotoPicker()
    func removeCourse()
}
