import Foundation


protocol FilterHandler: CourseFilter {
    associatedtype Value: RawRepresentable
    var stateDidChange: ((_ filter: Value, _ isSelected: Bool) -> Void)? { get set }
}
