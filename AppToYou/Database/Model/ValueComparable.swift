import Foundation


protocol ValueComparable: Comparable {
    associatedtype ComparableValue: Comparable
    var comparableValue: ComparableValue { get }
}
