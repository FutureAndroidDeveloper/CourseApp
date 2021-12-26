import Foundation


class CourseCategoryModel: ValidatableModel {
    
    let categories: [ATYCourseCategory]
    private(set) var selectedCategories: [ATYCourseCategory]
    var errorNotification: ((CourseError?) -> Void)?
    
    convenience init(categories: [ATYCourseCategory]) {
        self.init(categories: categories, selectedCategories: [])
    }
    
    init(categories: [ATYCourseCategory], selectedCategories: [ATYCourseCategory]) {
        self.categories = categories
        self.selectedCategories = selectedCategories
    }
    
    func update(selected: [ATYCourseCategory]) {
        selectedCategories = selected
    }
    
}
