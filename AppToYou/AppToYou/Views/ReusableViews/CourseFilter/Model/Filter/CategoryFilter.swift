import Foundation


class CategoryFilter: FilterHandler {
    private let category: ATYCourseCategory
    
    var stateDidChange: ((ATYCourseCategory, Bool) -> Void)?
    var title: String?
    var isSelected: Bool {
        didSet {
            stateDidChange?(category, isSelected)
        }
    }
    
    init(category: ATYCourseCategory, isSelected: Bool = false) {
        self.category = category
        self.isSelected = isSelected
        self.title = category.title
    }
}
