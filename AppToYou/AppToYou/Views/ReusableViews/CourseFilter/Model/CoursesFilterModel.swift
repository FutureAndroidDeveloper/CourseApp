import Foundation


class CoursesFilterModel {
    weak var delegate: CourseFilterDelegate?
    
    private(set) var activeFilters: [CourseFilter]
    
    private let categoryFilters: [CategoryFilter]
    private let membershipFilters: [MembershipFilter]
    
    
    init() {
        activeFilters = []
        categoryFilters = ATYCourseCategory.allCases
            .filter { $0 != .EMPTY }
            .map { CategoryFilter(category: $0) }
        
        membershipFilters = CourseMembership.allCases.map { MembershipFilter(membership: $0) }
        membershipFilters.first?.isSelected = true
        
        configure()
    }
    
    func activateCategoryFilters() {
        activeFilters = categoryFilters
        delegate?.coursesFilterDidActive()
    }
    
    func activateMemebershipFilters() {
        activeFilters = membershipFilters
        delegate?.membershipFilterDidActive()
    }
    
    private func configure() {
        categoryFilters.forEach { $0.stateDidChange = handleCategoryChange }
        membershipFilters.forEach { $0.stateDidChange = handleMemebershipChange }
    }
    
    private func handleCategoryChange(_ category: ATYCourseCategory, _ isSelected: Bool) {
        if isSelected {
            delegate?.categorySelected(category)
        } else {
            delegate?.categoryDeselected(category)
        }
    }
    
    private func handleMemebershipChange(_ membership: CourseMembership, _ isSelected: Bool) {
        guard isSelected else {
            return
        }
        switch membership {
        case .all:
            delegate?.allUserCoursesSelected()
        case .admin:
            delegate?.adminCoursesSelected()
        case .member:
            delegate?.membershipCoursesSelected()
        case .request:
            delegate?.requestCoursesSelected()
        }
    }
}
