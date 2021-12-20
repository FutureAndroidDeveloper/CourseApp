import Foundation

protocol TaskCreation {
    associatedtype Model
    associatedtype Delegate
    
    var model: Model { get set }
    var delegate: Delegate? { get set }
    
    func construct()
    func getModels() -> [AnyObject]
}
