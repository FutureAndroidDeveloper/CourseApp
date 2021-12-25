import Foundation


protocol ValidationError: Error {
    var message: String? { get }
}
