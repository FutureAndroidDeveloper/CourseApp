import UIKit


protocol CreateCourseDataSource: AnyObject {
    func getNameModel() -> TextFieldModel
    func getDescriptionModel() -> PlaceholderTextViewModel
    
    func getPhoto() -> (photo: UIImage?, placeholder: UIImage?)
    func getCategoriesModel() -> CourseCategoryModel
    func getCourseType() -> ATYCourseType
    
    func getPaymentModel() -> NaturalNumberFieldModel
    func getDurationModel() -> (TaskDurationModel, TitledCheckBoxModel)
    func getChatModel() -> TextFieldModel
}
