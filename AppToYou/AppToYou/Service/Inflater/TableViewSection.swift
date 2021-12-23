import Foundation


class TableViewSection {
    
    let header: AnyObject?
    let models: [AnyObject]
    
    init(models: [AnyObject], header: AnyObject? = nil) {
        self.models = models
        self.header = header
    }
    
}
