import Foundation


protocol CourseFilter: AnyObject {
    var title: String? { get }
    var isSelected: Bool { get set }
}
