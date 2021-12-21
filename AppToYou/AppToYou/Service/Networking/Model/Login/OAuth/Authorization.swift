import Foundation


enum Authorization: String {
    case google
    case apple
    case facebook
    
    var value: String {
        return self.rawValue.uppercased()
    }
    
}
