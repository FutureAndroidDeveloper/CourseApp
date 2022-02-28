import UIKit


protocol TaskAction {
    var delegate: TaskActionDelegate? { get }
    
    func update()
}

protocol TaskActionDelegate: AnyObject {
}


class TaskSwitchActionModel: TaskAction {
    weak var delegate: TaskActionDelegate?
    
    func update() {
        //
    }
    
    
}
