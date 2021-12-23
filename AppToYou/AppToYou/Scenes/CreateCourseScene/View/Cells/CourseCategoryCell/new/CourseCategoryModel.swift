import Foundation


class CourseCategoryModel {
    let categories: [ATYCourseCategory]
    private(set) var selectedCategories: [ATYCourseCategory]
    
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
