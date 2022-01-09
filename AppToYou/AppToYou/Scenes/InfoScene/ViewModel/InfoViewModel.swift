import Foundation


protocol InfoViewModelInput: AnyObject {
    
}


protocol InfoViewModelOutput: AnyObject {
    var sections: Observable<[TableViewSection]> { get }
    var updatedState: Observable<Void> { get }
}


protocol InfoViewModel: AnyObject {
    var input: InfoViewModelInput { get }
    var output: InfoViewModelOutput { get }
}


extension InfoViewModel where Self: InfoViewModelInput & InfoViewModelOutput {
    var input: InfoViewModelInput { return self }
    var output: InfoViewModelOutput { return self }
}
