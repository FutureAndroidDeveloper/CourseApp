import UIKit


protocol CreateCourseDataSource: AnyObject {
    func getNameModel() -> TextFieldModel
    func getDescriptionModel() -> PlaceholderTextViewModel
    
    func getCategoriesModel() -> CourseCategoryModel
    func getCourseType() -> ATYCourseType
    
    func getPaymentModel() -> NaturalNumberFieldModel
    func getDurationModel() -> (TaskDurationModel, TitledCheckBoxModel)
    func getChatModel() -> TextFieldModel
}
