import Foundation
import UIKit


enum Authorization: String, CaseIterable {
    case google
    case apple
//    case facebook
    
    var value: String {
        return self.rawValue.uppercased()
    }
}
